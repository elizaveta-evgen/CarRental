//
//  PrimaryButton.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isEnabled = true
    var isLoading = false
    let action: () -> Void

    var body: some View {
        self.content
    }
}

private extension PrimaryButton
{
    var content: some View {
        Button(action: self.action) {
            self.label
        }
        .disabled(!self.isEnabled || self.isLoading)
        .padding()
        .background(.regularMaterial)
    }

    var label: some View {
        Group {
            if self.isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(self.title)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(self.isEnabled ? Color.black : Color(.systemGray3))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
