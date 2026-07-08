//
//  CarListView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel: CarListViewModel

    init(viewModel: CarListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        self.content
    }
}

private extension CarListView
{
    var content: some View {
        VStack(spacing: 16) {
            self.titleText
            self.subtitleText
        }
        .padding()
    }

    var titleText: some View {
        Text(self.viewModel.title)
            .font(.largeTitle)
            .fontWeight(.bold)
    }

    var subtitleText: some View {
        Text(self.viewModel.subtitle)
            .font(.body)
            .foregroundColor(.secondary)
    }
}
