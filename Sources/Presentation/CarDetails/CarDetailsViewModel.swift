//
//  CarDetailsViewModel.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

@MainActor
final class CarDetailsViewModel: ObservableObject {
    let car: Car

    init(car: Car) {
        self.car = car
    }

    var title: String {
        self.car.name
    }

    var location: String {
        self.car.location
    }

    var priceText: String {
        PriceFormatter.rubles(self.car.price)
    }

    var photoURLs: [URL] {
        self.car.media.compactMap { $0.fullURL }
    }

    var characteristics: [CarCharacteristic] {
        [
            CarCharacteristic(label: "Коробка передач", value: self.car.transmission.title),
            CarCharacteristic(label: "Сторона руля", value: self.car.steering.title),
            CarCharacteristic(label: "Тип кузова", value: self.car.bodyType.title),
            CarCharacteristic(label: "Цвет", value: self.car.color.title)
        ]
    }
}
