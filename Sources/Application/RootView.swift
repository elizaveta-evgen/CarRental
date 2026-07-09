//
//  RootView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        self.content
    }
}

private extension RootView
{
    var content: some View {
        NavigationStack(path: self.$coordinator.path) {
            self.rootScreen
                .navigationDestination(for: Car.self) { car in
                    self.carDetails(for: car)
                }
                .navigationDestination(for: BookingStep.self) { step in
                    self.bookingStep(step)
                }
        }
    }

    @ViewBuilder
    var rootScreen: some View {
        switch self.coordinator.route {
        case .carList:
            CarListView(
                viewModel: self.coordinator.makeCarListViewModel(),
                rentalPeriod: self.$coordinator.rentalPeriod,
                onSelectCar: { self.coordinator.showCarDetails($0) }
            )
        }
    }

    func carDetails(for car: Car) -> some View {
        CarDetailsView(
            viewModel: self.coordinator.makeCarDetailsViewModel(for: car),
            onBook: { self.coordinator.startBooking(for: car) }
        )
    }

    @ViewBuilder
    func bookingStep(_ step: BookingStep) -> some View {
        if let viewModel = self.coordinator.bookingViewModel {
            switch step {
            case .dates:
                BookingDatesView(viewModel: viewModel, onContinue: { self.coordinator.goToPersonalData() })
            case .personalData:
                BookingPersonalDataView(viewModel: viewModel, onContinue: { self.coordinator.goToReview() })
            case .review:
                BookingReviewView(viewModel: viewModel, onBooked: { self.coordinator.goToConfirmation() })
            case .confirmation:
                BookingConfirmationView(viewModel: viewModel, onFinish: { self.coordinator.finishBooking() })
            }
        }
    }
}
