//
//  CarListView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel: CarListViewModel

    init(viewModel: CarListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        self.content
            .task {
                await self.viewModel.loadCars()
            }
    }
}

private extension CarListView
{
    @ViewBuilder
    var content: some View {
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

    func list(for cars: [Car]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                self.title
                ForEach(cars) { car in
                    CarCardView(car: car)
                }
            }
            .padding()
        }
    }

    var title: some View {
        Text("Аренда машины")
            .font(.largeTitle)
            .fontWeight(.bold)
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
