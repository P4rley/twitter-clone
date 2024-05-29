//
//  AuthService.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Firebase
import FirebaseFirestoreSwift

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func createUser (withEmail email: String, fullname: String, password: String, dateOfBirth: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            try await uploadUserData(withEmail: email, username: fullname, id: result.user.uid, fullname: fullname, dateOfBirth: dateOfBirth)

            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw NSError(domain: "com.example", code: 42, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw NSError(domain: "com.example", code: 42, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
        }
    }
    
    func signOut() {
        /// sign out on backend
        try? Auth.auth().signOut()
        
//        This removes session locally and updates routing
        self.userSession = nil
        
//        Set current user object to nil
        UserService.shared.reset()
    }
    
    @MainActor
    private func uploadUserData(
        withEmail email: String, 
        username: String,
        id: String,
        fullname: String,
        dateOfBirth: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username, dateOfBirth: dateOfBirth)
        
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        
        UserService.shared.currentUser = user
    }
}
