//
//  LoginView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showBottomRegistrationScreen = false
    @State private var showBottomLoginScreen = false
    
    var body: some View {
        let textColor: Color = colorScheme == .dark ? .white : .black
        NavigationStack {
            ZStack {
                VStack {
                    
                    Spacer()
                    
                    Text("See what's happening in the world right now.")
                        .padding(.horizontal)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    Button {
                        showBottomRegistrationScreen.toggle()
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
                    
                    Button {
                        showBottomLoginScreen.toggle()
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
                    isPresented: $showBottomRegistrationScreen,
                    onDismiss: {
                        showBottomRegistrationScreen = false
                    },
                    content: {
                       RegistrationView()
                })
                .fullScreenCover(
                    isPresented: $showBottomLoginScreen,
                    onDismiss: {
                        showBottomLoginScreen = false
                    },
                    content: {
                       LoginView()
                })
            }
        }
    }
}

#Preview {
    HomeView()
}
