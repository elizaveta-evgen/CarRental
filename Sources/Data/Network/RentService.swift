//
//  RentService.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CarRentResponse: Decodable {
    let success: Bool
    let rent: CarRent
}

protocol RentServiceProtocol {
    func createRent(_ dto: CreateRentDto) async throws -> CarRent
}

final class RentService: RentServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let encoder: JSONEncoder

    init(networkService: NetworkServiceProtocol = NetworkService(), encoder: JSONEncoder = JSONEncoder()) {
        self.networkService = networkService
        self.encoder = encoder
    }

    func createRent(_ dto: CreateRentDto) async throws -> CarRent {
        let body = try self.encoder.encode(dto)
        let endpoint = Endpoint(path: "/api/cars/rent", method: .post, body: body)
        let response: CarRentResponse = try await self.networkService.request(endpoint)
        return response.rent
    }
}
