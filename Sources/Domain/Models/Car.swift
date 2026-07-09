//
//  Car.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct Car: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let brand: String
    let media: [Media]
    let transmission: Transmission
    let price: Int
    let location: String
    let color: CarColor
    let bodyType: BodyType
    let steering: Steering
}

extension Car
{
    var coverURL: URL? {
        let cover = self.media.first(where: { $0.isCover }) ?? self.media.first
        guard let urlString = cover?.url else { return nil }
        return URL(string: urlString)
    }
}
