//
//  LoginView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Log in to X")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                
                
                
                TextInputField("Email", text: $email)
                
                SecureInputField("Password", text: $password)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 160) {
                    
                    Button() {
                        
                    } label: {
                        Text("Forgot password?")
                    }
                    
                    
                    Button {
                      
                    } label: {
                        Text("Login")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(.black)
                            .cornerRadius(20)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            
                    }
                }
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}



