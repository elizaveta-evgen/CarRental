//
//  CarsService.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

protocol CarsServiceProtocol {
    func fetchCars(filter: CarFilter) async throws -> [Car]
}

final class CarsService: CarsServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchCars(filter: CarFilter) async throws -> [Car] {
        let endpoint = Endpoint(path: "/api/cars/info", queryItems: filter.queryItems)
        let response: CarsResponse = try await self.networkService.request(endpoint)
        return response.data
    }
}
