//
//  PriceFormatter.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

enum PriceFormatter {
    static func rubles(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let number = formatter.string(from: NSNumber(value: amount)) ?? String(amount)
        return "\(number) ₽"
    }
}
