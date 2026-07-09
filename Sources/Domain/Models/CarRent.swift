//
//  CarRent.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CarRent: Decodable, Equatable {
    let id: String
    let status: String
    let totalPrice: Int
    let startDate: Int
    let endDate: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case totalPrice
        case startDate
        case endDate
    }
}
