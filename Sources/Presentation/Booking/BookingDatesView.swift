//
//  BookingDatesView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct BookingDatesView: View {
    @ObservedObject var viewModel: BookingViewModel
    let onContinue: () -> Void

    var body: some View {
        self.content
    }
}

private extension BookingDatesView
{
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StepIndicator(step: 1)
                self.datesSection
                TitledTextField(title: "Место получения", placeholder: "Адрес", text: self.$viewModel.pickupLocation)
                TitledTextField(title: "Место возврата", placeholder: "Адрес", text: self.$viewModel.returnLocation)
            }
            .padding()
        }
        .navigationTitle("Бронирование машины")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(
                title: "Продолжить",
                isEnabled: self.viewModel.canContinueDates,
                action: self.onContinue
            )
        }
    }

    var datesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DatePicker("Начало аренды", selection: self.$viewModel.startDate, displayedComponents: .date)
            DatePicker("Окончание аренды", selection: self.$viewModel.endDate, displayedComponents: .date)
            Text("Аренда на \(self.viewModel.rentDays) дн. · \(self.viewModel.estimatedTotalText)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
