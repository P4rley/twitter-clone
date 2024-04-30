//
//  RegistrationView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct RegistrationView: View {
    
    /// State
    @State private var name = ""
    @State private var email = ""
    @State private var dateOfBirth = ""
    @State private var selectedDate: Date? = nil
    @State private var isDateSelected: Bool = false
    @State private var isDatePickerVisible = false
    
    /// Environment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Create your account")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .padding(12)
                    
                
                TextInputField("Name", text: $name)
                    .onTapGesture {
                        self.isDatePickerVisible = false
                        self.hideKeyboard()
                    }
                
                TextInputField("Email", text: $email)
                    .onTapGesture {
                        self.isDatePickerVisible = false
                        self.hideKeyboard()
                    }
                
                TextInputField("Date of birth", text: $dateOfBirth)
                    .disabled(self.isDatePickerVisible)
                    .onTapGesture {
                        self.isDatePickerVisible.toggle()
                        self.hideKeyboard()
                    }
                    .onDisappear {
                        self.isDatePickerVisible = false
                    }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        print("DEBUG: \(name), \(email), \(isDatePickerVisible)")
                    } label: {
                        Text("Next")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.black)
                            .cornerRadius(24)
                    }
                }
                .padding()
                
                if isDatePickerVisible {
                    DatePickerField("Date of birth", text: $dateOfBirth)
                }
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
        }}
    
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


