//
//  TextInputField.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 01/04/24.
//

import SwiftUI

struct TextInputField: View {
    var title: String
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
    
        VStack {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(y: text.isEmpty ? 0 : -25)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("", text: $text)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .animation(.default, value: 0.75)
            .overlay (
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 35, height: 1)
                    .foregroundStyle(Color(.placeholderText))
                    ,
                alignment: .bottom
            )
            .padding(.vertical, 10)
        }
        
    }
}

#Preview {
    TextInputField("", text: .constant(""))
}
