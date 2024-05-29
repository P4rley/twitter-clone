//
//  RegistrationView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct RegistrationView: View {
    
    /// State
    @StateObject var viewModel = RegistrationViewModel()
    @State private var selectedDate: Date? = nil
    @State private var isDateSelected: Bool = false
    @State private var isDatePickerVisible = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    /// Environment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Create your account")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .padding(12)
                
                
                TextInputField("Full Name", text: $viewModel.fullname)
                    .onTapGesture {
                        self.isDatePickerVisible = false
                        self.hideKeyboard()
                    }
                
                TextInputField("Email", text: $viewModel.email)
                    .onTapGesture {
                        self.isDatePickerVisible = false
                        self.hideKeyboard()
                    }
                
                TextInputField("Date of birth", text: $viewModel.dateOfBirth)
                    .disabled(self.isDatePickerVisible)
                    .onTapGesture {
                        self.isDatePickerVisible.toggle()
                        self.hideKeyboard()
                    }
                    .onDisappear {
                        self.isDatePickerVisible = false
                    }
                
                SecureInputField("Password", text: $viewModel.password)
                    .onTapGesture {
                        self.isDatePickerVisible = false
                        self.hideKeyboard()
                    }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        Task {
                            isLoading = true
                            
                            do {
                                try await viewModel.createUser()
                                
                                dismiss()
                            } catch {
                                errorMessage = error.localizedDescription
                                showAlert = true
                            }
                            
                            isLoading = false
                        }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .padding(.horizontal, 38 )
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(24)
                                .tint(.white)
                        } else {
                            Text("Sign Up")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(24)
                                .opacity(viewModel.fullname.isEmpty || viewModel.email.isEmpty || viewModel.dateOfBirth.isEmpty || viewModel.password.isEmpty ? 0.5 : 1)
                        }
                    }
                    
                    .disabled(viewModel.fullname.isEmpty || viewModel.email.isEmpty || viewModel.dateOfBirth.isEmpty || viewModel.password.isEmpty)
                }
                .padding()
                
                if isDatePickerVisible {
                    DatePickerField("Date of birth", text: $viewModel.dateOfBirth)
                }
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
    
    // Helper method to format date to string
        func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        

}



#Preview {
    RegistrationView()
}


