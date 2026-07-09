//
//  CarListViewModel.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

@MainActor
final class CarListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var filter = CarFilter()
    @Published private(set) var state: CarListState = .loading

    private let carsService: CarsServiceProtocol

    init(carsService: CarsServiceProtocol = CarsService()) {
        self.carsService = carsService
    }

    var hasActiveFilters: Bool {
        self.filter.hasSelection
    }

    func loadCars() async {
        self.state = .loading
        var request = self.filter
        request.search = self.searchText
        do {
            let cars = try await self.carsService.fetchCars(filter: request)
            self.state = .loaded(cars)
        } catch {
            self.state = .failed("Не удалось загрузить машины")
        }
    }

    func applyFilter(_ filter: CarFilter) async {
        self.filter = filter
        await self.loadCars()
    }

    func resetFilter() async {
        self.filter = CarFilter()
        await self.loadCars()
    }
}
