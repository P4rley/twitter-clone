//
//  ExploreSearchView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 16/05/24.
//

import SwiftUI

struct ExploreSearchView: View {
    @State private var text: String = ""
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            SearchInputField(text: $text)
                .padding(.horizontal)
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ForEach(0...4, id: \.self) { _ in
                            Button {
                                
                            } label: {
                                NavigationLink(destination: ProfileView()) {
                                    HStack(alignment: .top, spacing: 5) {
                                        CircularImageView(size: .large)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("John Doe")
                                                .font(.system(size: 16))
                                                .font(.system(size: 16))
                                                .foregroundStyle(Color(.black))
                                            
                                            Text("@John_Doe")
                                                .font(.system(size: 16))
                                                .font(.system(size: 16))
                                                .foregroundStyle(Color(.systemGray2))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        Text("Go to @\(text)")
                            .padding(.horizontal)
                    }
                    .background(
                        GeometryReader { proxy -> Color in
                            withAnimation {
                                DispatchQueue.main.async {
                                    
                                    scrollOffset = proxy.frame(in: .named("scroll")).origin.y
                                    
                                    if abs(self.scrollOffset) > 100 { // arbitrary threshold to detect meaningful scroll
                                        
                                        self.dismissKeyboard()
                                        
                                    }
                                }
                            }
                            
                            return Color.clear
                        }
                    )
                }
                .navigationBarBackButtonHidden(true)
                .coordinateSpace(name: "scroll")
            }
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ExploreSearchView()
}
