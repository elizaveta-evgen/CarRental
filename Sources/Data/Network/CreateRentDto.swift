//
//  CreateRentDto.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CreateRentDto: Encodable {
    let carId: String
    let pickupLocation: String
    let returnLocation: String
    let startDate: Int
    let endDate: Int
    let firstName: String
    let lastName: String
    let middleName: String?
    let birthDate: String
    let email: String
    let phone: String
    let comment: String?
}
