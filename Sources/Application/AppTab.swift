//
//  AppTab.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

enum AppTab {
    case rent
    case history
    case profile

    var title: String {
        switch self {
        case .rent: "Аренда"
        case .history: "История"
        case .profile: "Профиль"
        }
    }

    var icon: String {
        switch self {
        case .rent: "car.fill"
        case .history: "clock.arrow.circlepath"
        case .profile: "person.fill"
        }
    }
}
