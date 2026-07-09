//
//  MockRentService.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

@testable import CarRental

final class MockRentService: RentServiceProtocol {
    private let result: Result<CarRent, Error>
    private(set) var receivedDto: CreateRentDto?

    init(result: Result<CarRent, Error>) {
        self.result = result
    }

    func createRent(_ dto: CreateRentDto) async throws -> CarRent {
        self.receivedDto = dto
        return try self.result.get()
    }
}
