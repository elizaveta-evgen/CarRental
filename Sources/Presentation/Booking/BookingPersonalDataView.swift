//
//  BookingPersonalDataView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct BookingPersonalDataView: View {
    @ObservedObject var viewModel: BookingViewModel
    let onContinue: () -> Void

    var body: some View {
        self.content
    }
}

private extension BookingPersonalDataView
{
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                StepIndicator(step: 2)
                TitledTextField(title: "Фамилия", placeholder: "Иванов", text: self.$viewModel.lastName)
                TitledTextField(title: "Имя", placeholder: "Иван", text: self.$viewModel.firstName)
                TitledTextField(title: "Отчество", placeholder: "Иванович", text: self.$viewModel.middleName)
                self.birthDatePicker
                TitledTextField(title: "Телефон", placeholder: "+7", text: self.$viewModel.phone, keyboard: .phonePad)
                TitledTextField(title: "Email", placeholder: "email@example.com", text: self.$viewModel.email, keyboard: .emailAddress)
                TitledTextField(title: "Комментарий", placeholder: "Введите дополнительную информацию", text: self.$viewModel.comment)
                self.agreementToggle
            }
            .padding()
        }
        .scrollDismissesKeyboard(.immediately)
        .hideKeyboardOnTap()
        .navigationTitle("Ваши данные")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(
                title: "Продолжить",
                isEnabled: self.viewModel.canContinuePersonalData,
                action: self.onContinue
            )
        }
    }

    var birthDatePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Дата рождения")
                .font(.subheadline)
                .foregroundColor(.secondary)
            DatePicker("Дата рождения", selection: self.$viewModel.birthDate, displayedComponents: .date)
                .labelsHidden()
        }
    }

    var agreementToggle: some View {
        Toggle(isOn: self.$viewModel.acceptedTerms) {
            Text("Принимаю условия соглашения")
                .font(.subheadline)
        }
        .tint(.black)
    }
}
