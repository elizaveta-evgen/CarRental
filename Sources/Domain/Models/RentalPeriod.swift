//
//  RentalPeriod.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

import Foundation

struct RentalPeriod: Equatable {
    var startDate: Date
    var endDate: Date

    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }

    init() {
        let today = Date()
        self.startDate = today
        self.endDate = Calendar.current.date(byAdding: .day, value: 7, to: today) ?? today
    }
}

extension RentalPeriod
{
    var days: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: self.startDate)
        let end = calendar.startOfDay(for: self.endDate)
        let difference = calendar.dateComponents([.day], from: start, to: end).day ?? 0
        return max(1, difference + 1)
    }

    var daysText: String {
        "\(self.days) \(self.dayWord(for: self.days))"
    }

    var datesText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return "\(formatter.string(from: self.startDate)) — \(formatter.string(from: self.endDate))"
    }
}

private extension RentalPeriod
{
    func dayWord(for count: Int) -> String {
        if (11...14).contains(count % 100) {
            return "дней"
        }
        switch count % 10 {
        case 1:
            return "день"
        case 2, 3, 4:
            return "дня"
        default:
            return "дней"
        }
    }
}
