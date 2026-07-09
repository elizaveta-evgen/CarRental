//
//  CarFilter.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CarFilter: Equatable {
    var search = ""
    var brand: CarBrand?
    var bodyType: BodyType?
    var transmission: Transmission?
    var steering: Steering?
    var color: CarColor?
    var minPrice: Int?
    var maxPrice: Int?
}

extension CarFilter
{
    var hasSelection: Bool {
        self.brand != nil
            || self.bodyType != nil
            || self.transmission != nil
            || self.steering != nil
            || self.color != nil
            || self.minPrice != nil
            || self.maxPrice != nil
    }

    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        let trimmedSearch = self.search.trimmingCharacters(in: .whitespaces)
        if !trimmedSearch.isEmpty {
            items.append(URLQueryItem(name: "search", value: trimmedSearch))
        }
        if let brand = self.brand {
            items.append(URLQueryItem(name: "brand", value: brand.rawValue))
        }
        if let bodyType = self.bodyType {
            items.append(URLQueryItem(name: "bodyType", value: bodyType.rawValue))
        }
        if let transmission = self.transmission {
            items.append(URLQueryItem(name: "transmission", value: transmission.rawValue))
        }
        if let steering = self.steering {
            items.append(URLQueryItem(name: "steering", value: steering.rawValue))
        }
        if let color = self.color {
            items.append(URLQueryItem(name: "color", value: color.rawValue))
        }
        if let minPrice = self.minPrice {
            items.append(URLQueryItem(name: "minPrice", value: String(minPrice)))
        }
        if let maxPrice = self.maxPrice {
            items.append(URLQueryItem(name: "maxPrice", value: String(maxPrice)))
        }
        return items
    }
}
