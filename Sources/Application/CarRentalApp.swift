//
//  CarRentalApp.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

@main
struct CarRentalApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            RootView(coordinator: self.coordinator)
        }
    }
}
