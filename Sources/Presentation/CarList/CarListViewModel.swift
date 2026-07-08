//
//  CarListViewModel.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

@MainActor
final class CarListViewModel: ObservableObject {
    @Published private(set) var title = "Аренда машин"
    @Published private(set) var subtitle = "Скоро здесь появится список машин"
}
