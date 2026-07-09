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
    let period: RentalPeriod

    init(car: Car, period: RentalPeriod = RentalPeriod()) {
        self.car = car
        self.period = period
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

    var rentalDaysText: String {
        "Аренда на \(self.period.daysText)"
    }

    var rentalDatesText: String {
        self.period.datesText
    }

    var totalText: String {
        PriceFormatter.rubles(self.car.price * self.period.days)
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
