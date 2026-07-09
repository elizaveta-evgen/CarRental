//
//  TitledTextField.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct TitledTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        self.content
    }
}

private extension TitledTextField
{
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField(self.placeholder, text: self.$text)
                .keyboardType(self.keyboard)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
