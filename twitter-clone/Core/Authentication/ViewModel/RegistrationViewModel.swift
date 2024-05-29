//
//  RegistrationViewModel.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var dateOfBirth = ""
    @Published var fullname = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, fullname: fullname, password: password, dateOfBirth: dateOfBirth)
    }
}
