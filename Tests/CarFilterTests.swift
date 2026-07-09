//
//  CarFilterTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import XCTest
@testable import CarRental

final class CarFilterTests: XCTestCase {
    func testEmptyFilterHasNoQueryItems() {
        XCTAssertTrue(CarFilter().queryItems.isEmpty)
    }

    func testBlankSearchIsIgnored() {
        var filter = CarFilter()
        filter.search = "   "

        XCTAssertTrue(filter.queryItems.isEmpty)
    }

    func testQueryItemsForSelectedValues() {
        var filter = CarFilter()
        filter.search = "haval"
        filter.transmission = .automatic
        filter.color = .black
        filter.minPrice = 3000
        filter.maxPrice = 5000

        let items = Dictionary(uniqueKeysWithValues: filter.queryItems.map { ($0.name, $0.value) })

        XCTAssertEqual(items["search"], "haval")
        XCTAssertEqual(items["transmission"], "automatic")
        XCTAssertEqual(items["color"], "black")
        XCTAssertEqual(items["minPrice"], "3000")
        XCTAssertEqual(items["maxPrice"], "5000")
    }

    func testHasSelection() {
        var filter = CarFilter()
        XCTAssertFalse(filter.hasSelection)

        filter.brand = .kia

        XCTAssertTrue(filter.hasSelection)
    }
}
