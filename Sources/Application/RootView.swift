//
//  RootView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        self.content
    }
}

private extension RootView
{
    @ViewBuilder
    var content: some View {
        switch self.coordinator.route {
        case .carList:
            CarListView(viewModel: self.coordinator.makeCarListViewModel())
        }
    }
}
