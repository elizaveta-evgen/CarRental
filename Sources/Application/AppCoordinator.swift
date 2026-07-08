//
//  AppCoordinator.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

@MainActor
final class AppCoordinator: ObservableObject {
    @Published private(set) var route: AppRoute

    init() {
        self.route = .carList
    }

    func makeCarListViewModel() -> CarListViewModel {
        CarListViewModel()
    }
}
