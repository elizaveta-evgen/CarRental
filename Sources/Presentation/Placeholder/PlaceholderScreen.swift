//
//  PlaceholderScreen.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

import SwiftUI

struct PlaceholderScreen: View {
    let title: String
    let icon: String
    let message: String

    var body: some View {
        self.content
    }
}

private extension PlaceholderScreen
{
    var content: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: self.icon)
                    .font(.system(size: 48))
                    .foregroundColor(.secondary)
                Text(self.message)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(self.title)
        }
    }
}
