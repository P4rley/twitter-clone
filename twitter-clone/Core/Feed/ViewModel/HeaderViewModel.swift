//
//  HeaderViewModel.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 03/04/24.
//

import SwiftUI

class HeaderViewModel: ObservableObject {
    
//    To Capture Start MinY For Calculation
    @Published var startMinY: CGFloat = 0
    
    @Published var offset: CGFloat = 0
    
    @Published var headerOffset: CGFloat = 0
    
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}

