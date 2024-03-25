//
//  Hidekeyboard.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 25/03/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

