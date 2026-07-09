//
//  CarListView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel: CarListViewModel
    @State private var showFilters = false
    private let onSelectCar: (Car) -> Void

    init(viewModel: CarListViewModel, onSelectCar: @escaping (Car) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectCar = onSelectCar
    }

    var body: some View {
        self.content
            .navigationTitle("Аренда машины")
            .task {
                await self.viewModel.loadCars()
            }
            .sheet(isPresented: self.$showFilters) {
                FiltersView(
                    initialFilter: self.viewModel.filter,
                    onApply: { filter in
                        Task { await self.viewModel.applyFilter(filter) }
                    }
                )
            }
    }
}

private extension CarListView
{
    var content: some View {
        VStack(spacing: 0) {
            self.searchBar
            self.stateContent
        }
    }

    var searchBar: some View {
        HStack(spacing: 12) {
            self.searchField
            self.filterButton
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Модель машины", text: self.$viewModel.searchText)
                .autocorrectionDisabled()
                .onSubmit {
                    Task { await self.viewModel.loadCars() }
                }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
    }

    var filterButton: some View {
        Button {
            self.showFilters = true
        } label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.primary)
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .overlay(alignment: .topTrailing) {
                    if self.viewModel.hasActiveFilters {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                }
        }
    }

    @ViewBuilder
    var stateContent: some View {
        switch self.viewModel.state {
        case .loading:
            self.loadingView
        case let .loaded(cars):
            self.list(for: cars)
        case let .failed(message):
            self.errorView(message)
        }
    }

    var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    func list(for cars: [Car]) -> some View {
        if cars.isEmpty {
            self.emptyView
        } else {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(cars) { car in
                        Button {
                            self.onSelectCar(car)
                        } label: {
                            CarCardView(car: car)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }

    var emptyView: some View {
        Text("Ничего не найдено")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Text(message)
                .foregroundColor(.secondary)
            Button("Повторить") {
                Task { await self.viewModel.loadCars() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
