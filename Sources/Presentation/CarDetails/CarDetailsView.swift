//
//  CarDetailsView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarDetailsView: View {
    @StateObject private var viewModel: CarDetailsViewModel
    @State private var selectedPhoto = 0
    private let onBook: () -> Void

    init(viewModel: CarDetailsViewModel, onBook: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onBook = onBook
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
                self.thumbnails
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
        TabView(selection: self.$selectedPhoto) {
            ForEach(Array(self.viewModel.photoURLs.enumerated()), id: \.offset) { index, url in
                self.photo(url)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    func photo(_ url: URL) -> some View {
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

    @ViewBuilder
    var thumbnails: some View {
        if self.viewModel.photoURLs.count > 1 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(self.viewModel.photoURLs.enumerated()), id: \.offset) { index, url in
                        self.thumbnail(url, index: index)
                    }
                }
            }
        }
    }

    func thumbnail(_ url: URL, index: Int) -> some View {
        self.photo(url)
            .frame(width: 72, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(self.selectedPhoto == index ? Color.black : Color.clear, lineWidth: 2)
            }
            .onTapGesture {
                self.selectedPhoto = index
            }
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
                .font(.headline)
            Text("\(self.viewModel.rentalDaysText) · \(self.viewModel.rentalDatesText)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Итого: \(self.viewModel.totalText)")
                .font(.title2)
                .fontWeight(.bold)
        }
    }

    var bookButton: some View {
        Button {
            self.onBook()
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
