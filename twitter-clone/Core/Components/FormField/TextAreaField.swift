//
//  TextAreaField.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 21/05/24.
//

import SwiftUI

struct TextAreaField: View {
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text) // <= Here
                .focused($isFocused)
                .limitText($text, to: 250)
                .onAppear {
                    // key part: delay setting isFocused until after some-internal-iOS setup
                    DispatchQueue.main.async {
                        isFocused = true
                    }
                }
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 12)
            }
        }
        .font(.body)
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

#Preview {
    TextAreaField("What's happening?", text: .constant(""))
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}
