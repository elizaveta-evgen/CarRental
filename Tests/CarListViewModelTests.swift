//
//  CarListViewModelTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import XCTest
@testable import CarRental

@MainActor
final class CarListViewModelTests: XCTestCase {
    func testLoadCarsSuccessSetsLoadedState() async {
        let car = Car.stub()
        let service = MockCarsService(result: .success([car]))
        let viewModel = CarListViewModel(carsService: service)

        await viewModel.loadCars()

        XCTAssertEqual(viewModel.state, .loaded([car]))
    }

    func testLoadCarsFailureSetsFailedState() async {
        let service = MockCarsService(result: .failure(NetworkError.invalidResponse))
        let viewModel = CarListViewModel(carsService: service)

        await viewModel.loadCars()

        XCTAssertEqual(viewModel.state, .failed("Не удалось загрузить машины"))
    }

    func testSearchTextIsSentToService() async {
        let service = MockCarsService(result: .success([]))
        let viewModel = CarListViewModel(carsService: service)
        viewModel.searchText = "haval"

        await viewModel.loadCars()

        XCTAssertEqual(service.receivedFilter?.search, "haval")
    }

    func testApplyFilterStoresAndSendsFilter() async {
        let service = MockCarsService(result: .success([]))
        let viewModel = CarListViewModel(carsService: service)
        var filter = CarFilter()
        filter.brand = .kia

        await viewModel.applyFilter(filter)

        XCTAssertEqual(viewModel.filter.brand, .kia)
        XCTAssertEqual(service.receivedFilter?.brand, .kia)
    }

    func testResetFilterClearsSelection() async {
        let service = MockCarsService(result: .success([]))
        let viewModel = CarListViewModel(carsService: service)
        var filter = CarFilter()
        filter.color = .red
        await viewModel.applyFilter(filter)

        await viewModel.resetFilter()

        XCTAssertFalse(viewModel.filter.hasSelection)
    }
}
