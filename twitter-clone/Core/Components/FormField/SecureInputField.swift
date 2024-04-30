//
//  SecureInputField.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 01/04/24.
//

import SwiftUI

struct SecureInputField: View {
    var title: String
    @Binding var text: String
    @State private var isShowPassword = false
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
    
        VStack {
            
            HStack {
                ZStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: text.isEmpty ? 0 : -25)
                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                    
                    if isShowPassword {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .padding(.vertical, 10)
                                
                Image(systemName: isShowPassword ? "eye" : "eye.slash")
                    .foregroundStyle(Color(.placeholderText))
                    .onTapGesture {
                        self.isShowPassword.toggle()
                    }
                
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            .animation(.default, value: 0.75)
            .overlay (
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 35, height: 1)
                    .foregroundStyle(Color(.placeholderText))
                    ,
                alignment: .bottom
            )
        }
        
    }
}

#Preview {
    SecureInputField("Title", text: .constant(""))
}
