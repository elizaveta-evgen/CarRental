//
//  RentalPeriodTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

import XCTest
@testable import CarRental

final class RentalPeriodTests: XCTestCase {
    func testDaysAreInclusive() {
        XCTAssertEqual(self.period(from: 1, to: 15).days, 15)
    }

    func testSingleDayIsOne() {
        XCTAssertEqual(self.period(from: 1, to: 1).days, 1)
    }

    func testDayWordPluralization() {
        XCTAssertEqual(self.period(from: 1, to: 1).daysText, "1 день")
        XCTAssertEqual(self.period(from: 1, to: 3).daysText, "3 дня")
        XCTAssertEqual(self.period(from: 1, to: 15).daysText, "15 дней")
        XCTAssertEqual(self.period(from: 1, to: 21).daysText, "21 день")
        XCTAssertEqual(self.period(from: 1, to: 22).daysText, "22 дня")
    }
}

private extension RentalPeriodTests
{
    func period(from startDay: Int, to endDay: Int) -> RentalPeriod {
        let calendar = Calendar.current
        return RentalPeriod(
            startDate: calendar.date(from: DateComponents(year: 2026, month: 8, day: startDay))!,
            endDate: calendar.date(from: DateComponents(year: 2026, month: 8, day: endDay))!
        )
    }
}
