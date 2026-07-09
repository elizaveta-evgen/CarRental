//
//  CarCharacteristic.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct CarCharacteristic: Identifiable {
    let id = UUID()
    let label: String
    let value: String
}
