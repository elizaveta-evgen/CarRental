//
//  AppCoordinatorTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import XCTest
@testable import CarRental

@MainActor
final class AppCoordinatorTests: XCTestCase {
    func testInitialRouteIsCarList() {
        let coordinator = AppCoordinator()

        XCTAssertEqual(coordinator.route, .carList)
    }

    func testMakeCarListViewModelStartsInLoading() {
        let coordinator = AppCoordinator()

        let viewModel = coordinator.makeCarListViewModel()

        XCTAssertEqual(viewModel.state, .loading)
    }

    func testShowCarDetailsPushesScreen() {
        let coordinator = AppCoordinator()

        coordinator.showCarDetails(.stub())

        XCTAssertEqual(coordinator.path.count, 1)
    }
}
