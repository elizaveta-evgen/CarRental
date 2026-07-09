//
//  BookingConfirmationView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct BookingConfirmationView: View {
    @ObservedObject var viewModel: BookingViewModel
    let onFinish: () -> Void

    var body: some View {
        self.content
    }
}

private extension BookingConfirmationView
{
    var content: some View {
        VStack(spacing: 20) {
            Spacer()
            self.icon
            self.title
            self.carName
            self.total
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "На главную", action: self.onFinish)
        }
    }

    var icon: some View {
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 72))
            .foregroundColor(.green)
    }

    var title: some View {
        Text("Машина забронирована")
            .font(.title2)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
    }

    var carName: some View {
        Text(self.viewModel.car.name)
            .font(.body)
            .foregroundColor(.secondary)
    }

    @ViewBuilder
    var total: some View {
        if let rent = self.viewModel.bookedRent {
            Text("Итого: \(PriceFormatter.rubles(rent.totalPrice))")
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}
