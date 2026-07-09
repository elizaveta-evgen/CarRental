//
//  CarDetailsView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarDetailsView: View {
    @StateObject private var viewModel: CarDetailsViewModel

    init(viewModel: CarDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        self.content
    }
}

private extension CarDetailsView
{
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                self.gallery
                self.header
                self.characteristics
                self.priceBlock
                self.bookButton
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    var gallery: some View {
        TabView {
            ForEach(self.viewModel.photoURLs, id: \.self) { url in
                AsyncImage(url: url) { phase in
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
            }
        }
        .tabViewStyle(.page)
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(self.viewModel.title)
                .font(.title)
                .fontWeight(.bold)
            Text(self.viewModel.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    var characteristics: some View {
        VStack(spacing: 12) {
            ForEach(self.viewModel.characteristics) { item in
                self.characteristicRow(item)
            }
        }
    }

    func characteristicRow(_ item: CarCharacteristic) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(item.label)
                    .foregroundColor(.secondary)
                Spacer()
                Text(item.value)
            }
            Divider()
        }
    }

    var priceBlock: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Стоимость")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(self.viewModel.priceText)
                .font(.title2)
                .fontWeight(.bold)
        }
    }

    var bookButton: some View {
        Button {
        } label: {
            Text("Забронировать")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
