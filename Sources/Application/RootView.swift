//
//  RootView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        self.content
    }
}

private extension RootView
{
    var content: some View {
        NavigationStack(path: self.$coordinator.path) {
            self.rootScreen
                .navigationDestination(for: Car.self) { car in
                    CarDetailsView(viewModel: self.coordinator.makeCarDetailsViewModel(for: car))
                }
        }
    }

    @ViewBuilder
    var rootScreen: some View {
        switch self.coordinator.route {
        case .carList:
            CarListView(
                viewModel: self.coordinator.makeCarListViewModel(),
                onSelectCar: { self.coordinator.showCarDetails($0) }
            )
        }
    }
}
