//
//  CarCardView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarCardView: View {
    let car: Car

    var body: some View {
        self.content
    }
}

private extension CarCardView
{
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            self.image
            self.name
            self.subtitle
            self.price
        }
    }

    var image: some View {
        AsyncImage(url: self.car.coverURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            default:
                Rectangle()
                    .fill(Color(.systemGray5))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    var name: some View {
        Text(self.car.name)
            .font(.headline)
    }

    var subtitle: some View {
        Text(self.car.transmission.title)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    var price: some View {
        Text(PriceFormatter.rubles(self.car.price))
            .font(.title3)
            .fontWeight(.bold)
    }
}
