//
//  NoTapAnimation.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 07/05/24.
//

import SwiftUI

struct NoTapAnimation: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // Make the whole button surface tappable. Without this only content in the label is tappable and not whitespace. Order is important so add it before the tap gesture
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
