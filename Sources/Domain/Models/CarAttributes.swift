//
//  CarAttributes.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

enum Transmission: String, Decodable, CaseIterable {
    case automatic
    case manual

    var title: String {
        switch self {
        case .automatic: "Автомат"
        case .manual: "Механика"
        }
    }
}

enum BodyType: String, Decodable, CaseIterable {
    case sedan
    case suv
    case coupe
    case hatchback
    case cabriolet

    var title: String {
        switch self {
        case .sedan: "Седан"
        case .suv: "Внедорожник"
        case .coupe: "Купе"
        case .hatchback: "Хэтчбек"
        case .cabriolet: "Кабриолет"
        }
    }
}

enum CarColor: String, Decodable, CaseIterable {
    case black
    case white
    case red
    case silver
    case blue
    case grey
    case orange

    var title: String {
        switch self {
        case .black: "Чёрный"
        case .white: "Белый"
        case .red: "Красный"
        case .silver: "Серебристый"
        case .blue: "Синий"
        case .grey: "Серый"
        case .orange: "Оранжевый"
        }
    }
}

enum Steering: String, Decodable, CaseIterable {
    case left
    case right

    var title: String {
        switch self {
        case .left: "Левый"
        case .right: "Правый"
        }
    }
}
