//
//  CarStub.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

@testable import CarRental

extension Car {
    static func stub(id: String = "1", name: String = "Dodge Challenger") -> Car {
        Car(
            id: id,
            name: name,
            brand: "dodge",
            media: [Media(url: "https://example.com/car.png", isCover: true)],
            transmission: .automatic,
            price: 8000,
            location: "Москва",
            color: .black,
            bodyType: .coupe,
            steering: .left
        )
    }
}
