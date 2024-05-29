//
//  BlurView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 07/05/24.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        return view
    }
    

}

