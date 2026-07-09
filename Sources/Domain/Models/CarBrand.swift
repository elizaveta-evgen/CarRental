//
//  CarBrand.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

enum CarBrand: String, CaseIterable {
    case haval
    case hyundai
    case volkswagen
    case kia
    case geely
    case mercedes

    var title: String {
        switch self {
        case .haval: "Haval"
        case .hyundai: "Hyundai"
        case .volkswagen: "Volkswagen"
        case .kia: "Kia"
        case .geely: "Geely"
        case .mercedes: "Mercedes"
        }
    }
}
