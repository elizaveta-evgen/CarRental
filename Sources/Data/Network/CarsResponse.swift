//
//  CarsResponse.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CarsResponse: Decodable {
    let success: Bool
    let data: [Car]
    let meta: CarsMeta
}

struct CarsMeta: Decodable {
    let total: Int
    let page: Int
    let limit: Int
    let totalPages: Int
}
