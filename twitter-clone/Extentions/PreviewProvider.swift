//
//  PreviewProvider.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreviewHelpers {
        return DeveloperPreviewHelpers.shared
    }
}

class DeveloperPreviewHelpers {
    static let shared = DeveloperPreviewHelpers()
}

