//
//  PriceFormatterTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import XCTest
@testable import CarRental

final class PriceFormatterTests: XCTestCase {
    func testFormatsThousandsWithSpace() {
        XCTAssertEqual(PriceFormatter.rubles(8000), "8 000 ₽")
    }

    func testFormatsSmallNumberWithoutSeparator() {
        XCTAssertEqual(PriceFormatter.rubles(500), "500 ₽")
    }
}
