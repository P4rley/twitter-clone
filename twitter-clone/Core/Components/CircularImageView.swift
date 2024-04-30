//
//  CircularImageView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI

enum ImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall:
            return 20
        case .xSmall:
            return 32
        case .small:
            return 40
        case .medium:
            return 48
        case .large:
            return 68
        case .xLarge :
            return 80
        }
    }
}

struct CircularImageView: View {
    let size: ImageSize
    
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .foregroundStyle(Color(.systemGray4))
            .frame(width: size.dimension, height: size.dimension)
    }
}

#Preview {
    CircularImageView(size: .medium)
}
