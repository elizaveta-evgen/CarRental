//
//  StepIndicator.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct StepIndicator: View {
    let step: Int

    var body: some View {
        self.content
    }
}

private extension StepIndicator
{
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Шаг \(self.step) из 3")
                .font(.subheadline)
                .foregroundColor(.secondary)
            ProgressView(value: Double(self.step), total: 3)
                .tint(.black)
        }
    }
}
