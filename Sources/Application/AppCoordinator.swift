//
//  AppCoordinator.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published private(set) var route: AppRoute
    @Published var selectedTab: AppTab = .rent
    @Published var path = NavigationPath()
    @Published var rentalPeriod = RentalPeriod()

    private(set) var bookingViewModel: BookingViewModel?

    init() {
        self.route = .carList
    }

    func showCarDetails(_ car: Car) {
        self.path.append(car)
    }

    func startBooking(for car: Car) {
        self.bookingViewModel = BookingViewModel(car: car, period: self.rentalPeriod)
        self.path.append(BookingStep.dates)
    }

    func goToPersonalData() {
        self.path.append(BookingStep.personalData)
    }

    func goToReview() {
        self.path.append(BookingStep.review)
    }

    func goToConfirmation() {
        self.path.append(BookingStep.confirmation)
    }

    func finishBooking() {
        self.path = NavigationPath()
        self.bookingViewModel = nil
    }

    func makeCarListViewModel() -> CarListViewModel {
        CarListViewModel(carsService: CarsService())
    }

    func makeCarDetailsViewModel(for car: Car) -> CarDetailsViewModel {
        CarDetailsViewModel(car: car, period: self.rentalPeriod)
    }
}
