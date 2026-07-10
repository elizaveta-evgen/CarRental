//
//  CarListView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel: CarListViewModel
    @Binding var rentalPeriod: RentalPeriod
    @State private var showFilters = false
    private let onSelectCar: (Car) -> Void

    init(viewModel: CarListViewModel, rentalPeriod: Binding<RentalPeriod>, onSelectCar: @escaping (Car) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._rentalPeriod = rentalPeriod
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
            self.header
            self.stateContent
        }
    }

    var header: some View {
        VStack(spacing: 12) {
            self.searchBar
            self.periodRow
            self.findButton
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .hideKeyboardOnTap()
    }

    var searchBar: some View {
        HStack(spacing: 12) {
            self.searchField
            self.filterButton
        }
    }

    var periodRow: some View {
        HStack(spacing: 12) {
            self.dateField(title: "Начало аренды", selection: self.$rentalPeriod.startDate)
            self.dateField(title: "Окончание аренды", selection: self.$rentalPeriod.endDate)
        }
    }

    func dateField(title: String, selection: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            DatePicker("", selection: selection, displayedComponents: .date)
                .labelsHidden()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var findButton: some View {
        Button {
            Task { await self.viewModel.loadCars() }
        } label: {
            Text("Найти машину")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
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
            .scrollDismissesKeyboard(.immediately)
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
