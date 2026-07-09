//
//  CarDetailsViewModelTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import XCTest
@testable import CarRental

@MainActor
final class CarDetailsViewModelTests: XCTestCase {
    func testTitleAndPrice() {
        let viewModel = CarDetailsViewModel(car: .stub())

        XCTAssertEqual(viewModel.title, "Dodge Challenger")
        XCTAssertEqual(viewModel.priceText, "8 000 ₽")
    }

    func testCharacteristicsMapping() {
        let viewModel = CarDetailsViewModel(car: .stub())

        let characteristics = viewModel.characteristics

        XCTAssertEqual(characteristics.count, 4)
        XCTAssertEqual(characteristics.first?.label, "Коробка передач")
        XCTAssertEqual(characteristics.first?.value, "Автомат")
    }
}
