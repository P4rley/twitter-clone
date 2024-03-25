//
//  RegistrationView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var dateOfBirth = ""
    @State private var selectedDate: Date? = nil
    @State private var isDateSelected: Bool = false
    @State private var isDatePickerVisible = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Create your account")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .padding(12)
                    
                
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.never)
                    .modifier(TextFieldModifier())
                    .onTapGesture {
                        self.isDatePickerVisible = false
                    }

                
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .modifier(TextFieldModifier())
                    .onTapGesture {
                        self.isDatePickerVisible = false
                    }
                
                
                
                VStack {
                    
                    TextField(isDateSelected ? formatDate(date: selectedDate ?? Date()) : "Date of birth", text: $dateOfBirth)
                        .modifier(TextFieldModifier())
                        .disabled(self.isDatePickerVisible)
                        .onTapGesture {
                            self.isDatePickerVisible.toggle()
                            //this line will do magic to hide keyboard
                            self.hideKeyboard()
                        }
                    
                    HStack() {
                        Spacer()
                        
                        Button {
                            print("DEBUG: LOGIN")
                        } label: {
                            Text("Next")
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.black)
                                .cornerRadius(20)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .opacity(name.isEmpty || email.isEmpty || dateOfBirth.isEmpty ? 0.5 : 1.0)
                                .disabled(name.isEmpty || email.isEmpty || dateOfBirth.isEmpty)
                        }
                        .padding()
                    }
                    
                    
                    
                    if isDatePickerVisible {
                        DatePicker("", selection: Binding<Date>(get: {
                            self.selectedDate ?? Date()
                        }, set: { newValue in
                            self.selectedDate = newValue
                            self.dateOfBirth = formatDate(date: self.selectedDate!)
                            self.isDateSelected = newValue != nil
                        }), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .frame(width: 320, height: 320)
                        .onDisappear {
                            self.isDatePickerVisible = false
                        }
                    }
                }
                
                
                Spacer()
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
