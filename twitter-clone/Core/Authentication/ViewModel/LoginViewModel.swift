//
//  LoginViewModel.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
