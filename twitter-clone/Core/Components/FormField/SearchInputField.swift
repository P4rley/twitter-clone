//
//  SearchInputField.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 16/05/24.
//

import SwiftUI

struct SearchInputField: View {
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) var dismiss
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(.systemGray5))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .overlay(
                    HStack(alignment: .center) {
                        HStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.placeholder)
                            
                            
                            TextField("Search", text: $text)
                                .focused($isFocused)
                                .onAppear {
                                    // key part: delay setting isFocused until after some-internal-iOS setup
                                    DispatchQueue.main.async {
                                        isFocused = true
                                    }
                                }
                                .frame(maxWidth: isFocused ? .infinity : 55)
                        }
                        .animation(.default, value: isFocused)
                        
                        if isFocused {
                            Spacer()
                        }
                        
                        if !text.isEmpty && isFocused {
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundStyle(Color.blue)
                                    .background(Color.clear)
                            }
                        }
                    }
                        .padding(.horizontal),
                    alignment: .center
                )
                .onTapGesture {
                    isFocused = true
                }
                
            
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.title2)
            }
        }
    }
}

#Preview {
    SearchInputField(text: .constant(""))
}
