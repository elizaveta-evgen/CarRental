//
//  BookingViewModel.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

enum BookingSubmitState: Equatable {
    case idle
    case loading
    case failed(String)
    case booked(CarRent)
}

@MainActor
final class BookingViewModel: ObservableObject {
    let car: Car

    @Published var startDate: Date
    @Published var endDate: Date
    @Published var pickupLocation = ""
    @Published var returnLocation = ""

    @Published var lastName = ""
    @Published var firstName = ""
    @Published var middleName = ""
    @Published var birthDate: Date
    @Published var phone = ""
    @Published var email = ""
    @Published var comment = ""
    @Published var acceptedTerms = false

    @Published private(set) var submitState: BookingSubmitState = .idle

    private let rentService: RentServiceProtocol

    init(car: Car, period: RentalPeriod = RentalPeriod(), rentService: RentServiceProtocol = RentService()) {
        self.car = car
        self.rentService = rentService
        self.startDate = period.startDate
        self.endDate = period.endDate
        self.birthDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? Date()
    }

    func submit() async {
        self.submitState = .loading
        do {
            let rent = try await self.rentService.createRent(self.makeDto())
            self.submitState = .booked(rent)
        } catch {
            self.submitState = .failed("Не удалось оформить бронь")
        }
    }
}

extension BookingViewModel
{
    var rentDays: Int {
        self.period.days
    }

    var estimatedTotalText: String {
        PriceFormatter.rubles(self.car.price * self.rentDays)
    }

    var datesText: String {
        self.period.datesText
    }

    var fullName: String {
        [self.lastName, self.firstName, self.middleName]
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    var canContinueDates: Bool {
        self.endDate > self.startDate
            && !self.pickupLocation.trimmingCharacters(in: .whitespaces).isEmpty
            && !self.returnLocation.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var canContinuePersonalData: Bool {
        !self.firstName.trimmingCharacters(in: .whitespaces).isEmpty
            && !self.lastName.trimmingCharacters(in: .whitespaces).isEmpty
            && self.phone.trimmingCharacters(in: .whitespaces).count >= 10
            && self.email.contains("@")
            && self.acceptedTerms
    }

    var isBooked: Bool {
        if case .booked = self.submitState {
            return true
        }
        return false
    }

    var bookedRent: CarRent? {
        if case let .booked(rent) = self.submitState {
            return rent
        }
        return nil
    }
}

private extension BookingViewModel
{
    var period: RentalPeriod {
        RentalPeriod(startDate: self.startDate, endDate: self.endDate)
    }

    var birthDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self.birthDate)
    }

    func milliseconds(from date: Date) -> Int {
        Int(date.timeIntervalSince1970 * 1000)
    }

    func trimmedOrNil(_ value: String) -> String? {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty ? nil : trimmed
    }

    func makeDto() -> CreateRentDto {
        CreateRentDto(
            carId: self.car.id,
            pickupLocation: self.pickupLocation,
            returnLocation: self.returnLocation,
            startDate: self.milliseconds(from: self.startDate),
            endDate: self.milliseconds(from: self.endDate),
            firstName: self.firstName,
            lastName: self.lastName,
            middleName: self.trimmedOrNil(self.middleName),
            birthDate: self.birthDateString,
            email: self.email,
            phone: self.phone,
            comment: self.trimmedOrNil(self.comment)
        )
    }
}
