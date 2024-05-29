//
//  LoginView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Log in to X")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                
                
                
                TextInputField("Email", text: $viewModel.email)
                
                SecureInputField("Password", text: $viewModel.password)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 160) {
                    
                    Button() {
                        
                    } label: {
                        Text("Forgot password?")
                    }
                    
                    
                    Button {
                        Task {
                            isLoading = true
                            
                            do {
                                try await viewModel.login()
                            } catch {
                                errorMessage = error.localizedDescription
                                showAlert = true
                            }
                            
                            isLoading = false
                        }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(24)
                                .tint(.white)
                        } else {
                            Text("Login")
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.bottom)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
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



