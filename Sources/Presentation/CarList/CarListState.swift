//
//  CarListState.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

enum CarListState: Equatable {
    case loading
    case loaded([Car])
    case failed(String)
}
