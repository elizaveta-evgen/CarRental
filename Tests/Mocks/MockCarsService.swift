//
//  MockCarsService.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

@testable import CarRental

final class MockCarsService: CarsServiceProtocol {
    private let result: Result<[Car], Error>
    private(set) var receivedFilter: CarFilter?

    init(result: Result<[Car], Error>) {
        self.result = result
    }

    func fetchCars(filter: CarFilter) async throws -> [Car] {
        self.receivedFilter = filter
        return try self.result.get()
    }
}
