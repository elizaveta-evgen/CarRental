//
//  AppCoordinator.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published private(set) var route: AppRoute
    @Published var path = NavigationPath()

    init() {
        self.route = .carList
    }

    func showCarDetails(_ car: Car) {
        self.path.append(car)
    }

    func makeCarListViewModel() -> CarListViewModel {
        CarListViewModel(carsService: CarsService())
    }

    func makeCarDetailsViewModel(for car: Car) -> CarDetailsViewModel {
        CarDetailsViewModel(car: car)
    }
}
