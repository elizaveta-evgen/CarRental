//
//  CarListViewModel.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

@MainActor
final class CarListViewModel: ObservableObject {
    @Published private(set) var state: CarListState = .loading

    private let carsService: CarsServiceProtocol

    init(carsService: CarsServiceProtocol = CarsService()) {
        self.carsService = carsService
    }

    func loadCars() async {
        self.state = .loading
        do {
            let cars = try await self.carsService.fetchCars()
            self.state = .loaded(cars)
        } catch {
            self.state = .failed("Не удалось загрузить машины")
        }
    }
}
