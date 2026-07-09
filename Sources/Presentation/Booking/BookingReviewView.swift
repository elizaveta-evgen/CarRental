//
//  BookingReviewView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct BookingReviewView: View {
    @ObservedObject var viewModel: BookingViewModel
    let onBooked: () -> Void

    var body: some View {
        self.content
    }
}

private extension BookingReviewView
{
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StepIndicator(step: 3)
                self.carSection
                self.customerSection
                self.priceRow
                self.errorMessage
            }
            .padding()
        }
        .navigationTitle("Проверка данных")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(
                title: "Забронировать",
                isLoading: self.viewModel.submitState == .loading,
                action: self.book
            )
        }
    }

    var carSection: some View {
        self.section(title: "Данные машины") {
            self.row(label: "Машина", value: self.viewModel.car.name)
            self.row(label: "Даты аренды", value: self.viewModel.datesText)
            self.row(label: "Место получения", value: self.viewModel.pickupLocation)
            self.row(label: "Место возврата", value: self.viewModel.returnLocation)
        }
    }

    var customerSection: some View {
        self.section(title: "Данные заказчика") {
            self.row(label: "ФИО", value: self.viewModel.fullName)
            self.row(label: "Телефон", value: self.viewModel.phone)
            self.row(label: "Email", value: self.viewModel.email)
        }
    }

    var priceRow: some View {
        HStack {
            Text("Итого")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text(self.viewModel.estimatedTotalText)
                .font(.title3)
                .fontWeight(.bold)
        }
    }

    @ViewBuilder
    var errorMessage: some View {
        if case let .failed(message) = self.viewModel.submitState {
            Text(message)
                .font(.subheadline)
                .foregroundColor(.red)
        }
    }

    func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content()
        }
    }

    func row(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }

    func book() {
        Task {
            await self.viewModel.submit()
            if self.viewModel.isBooked {
                self.onBooked()
            }
        }
    }
}
