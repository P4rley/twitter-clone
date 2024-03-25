//
//  LoginView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

enum Theme {
    static let primary = Color("Primary")
}



struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showBottomScreen = false
    @State private var currentBottomScreen = ""
    
    var body: some View {
        let textColor: Color = colorScheme == .dark ? .white : .black
        
        NavigationStack {
            ZStack {
                Theme.primary.ignoresSafeArea()
                VStack {
                    
                    Spacer()
                    
                    Text("See what's happening in the world right now.")
                        .padding(.horizontal)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    Button {
                        showBottomScreen.toggle()
                    } label: {
                        Text("Create account")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .cornerRadius(24)
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        
                    } label: {
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                                .foregroundStyle(textColor)
                            
                            Text("Log in")
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal)
                        .font(.system(size: 12))
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("x-logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                    }
                }
                .fullScreenCover(
                    isPresented: $showBottomScreen,
                    onDismiss: {
                        showBottomScreen = false
                    },
                    content: {
                    RegistrationView()
                })
            }
        }
    }
}

#Preview {
    LoginView()
}
