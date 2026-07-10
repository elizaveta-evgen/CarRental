//
//  UIResponder+Keyboard.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 10.07.2026.
//

import SwiftUI

extension UIResponder
{
    static func resignCurrentResponder() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

extension View
{
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIResponder.resignCurrentResponder()
        }
    }
}
