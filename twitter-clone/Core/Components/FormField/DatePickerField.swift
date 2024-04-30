//
//  DatePickerField.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 01/04/24.
//

import SwiftUI

struct DatePickerField: View {

    @State private var selectedDate: Date? = nil
    @State private var isDateSelected = false
   
    
    var title: String

    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        VStack {
            DatePicker("", selection: Binding<Date>(get: {
                self.selectedDate ?? Date()
            }, set: { newValue in
                self.selectedDate = newValue
                self.text = formatDate(date: self.selectedDate!)
                self.isDateSelected = newValue != nil
            }), displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .frame(height: 300)
            .id(selectedDate)
            .onAppear {
                self.selectedDate = Date()
            }

        }
    }
}

#Preview {
    DatePickerField("Date", text: .constant(""))
}

// Helper method to format date to string
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    

