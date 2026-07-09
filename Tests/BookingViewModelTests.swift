//
//  BookingViewModelTests.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

import XCTest
@testable import CarRental

@MainActor
final class BookingViewModelTests: XCTestCase {
    func testCannotContinueDatesWhenLocationsEmpty() {
        let viewModel = self.makeViewModel()

        XCTAssertFalse(viewModel.canContinueDates)
    }

    func testCanContinueDatesWhenLocationsFilled() {
        let viewModel = self.makeViewModel()
        viewModel.pickupLocation = "Москва"
        viewModel.returnLocation = "Москва"

        XCTAssertTrue(viewModel.canContinueDates)
    }

    func testPersonalDataRequiresAgreement() {
        let viewModel = self.makeViewModel()
        viewModel.firstName = "Иван"
        viewModel.lastName = "Иванов"
        viewModel.phone = "79990000000"
        viewModel.email = "ivan@example.com"

        XCTAssertFalse(viewModel.canContinuePersonalData)

        viewModel.acceptedTerms = true

        XCTAssertTrue(viewModel.canContinuePersonalData)
    }

    func testRentDaysAreInclusive() {
        let viewModel = self.makeViewModel()
        let calendar = Calendar.current
        viewModel.startDate = calendar.date(from: DateComponents(year: 2026, month: 8, day: 1))!
        viewModel.endDate = calendar.date(from: DateComponents(year: 2026, month: 8, day: 15))!

        XCTAssertEqual(viewModel.rentDays, 15)
    }

    func testSubmitSuccessSetsBookedRent() async {
        let viewModel = self.makeViewModel(result: .success(.stub(totalPrice: 63000)))

        await viewModel.submit()

        XCTAssertTrue(viewModel.isBooked)
        XCTAssertEqual(viewModel.bookedRent?.totalPrice, 63000)
    }

    func testSubmitFailureSetsFailedState() async {
        let viewModel = self.makeViewModel(result: .failure(NetworkError.invalidResponse))

        await viewModel.submit()

        XCTAssertFalse(viewModel.isBooked)
        XCTAssertEqual(viewModel.submitState, .failed("Не удалось оформить бронь"))
    }

    func testSubmitBuildsDtoWithCarIdAndLocations() async {
        let service = MockRentService(result: .success(.stub()))
        let viewModel = BookingViewModel(car: .stub(), rentService: service)
        viewModel.pickupLocation = "Адрес A"
        viewModel.returnLocation = "Адрес B"

        await viewModel.submit()

        XCTAssertEqual(service.receivedDto?.carId, Car.stub().id)
        XCTAssertEqual(service.receivedDto?.pickupLocation, "Адрес A")
        XCTAssertGreaterThan(service.receivedDto?.startDate ?? 0, 0)
    }
}

private extension BookingViewModelTests
{
    func makeViewModel(result: Result<CarRent, Error> = .success(.stub())) -> BookingViewModel {
        BookingViewModel(car: .stub(), rentService: MockRentService(result: result))
    }
}
