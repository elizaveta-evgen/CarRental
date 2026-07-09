//
//  CarRentStub.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

@testable import CarRental

extension CarRent {
    static func stub(totalPrice: Int = 63000) -> CarRent {
        CarRent(
            id: "rent1",
            status: "booked",
            totalPrice: totalPrice,
            startDate: 0,
            endDate: 0
        )
    }
}
