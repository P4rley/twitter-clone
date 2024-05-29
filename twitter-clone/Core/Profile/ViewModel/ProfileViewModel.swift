//
//  ProfileViewModel.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            
            print("DEBUG: User in view model from combine is \(user)")
        }.store(in: &cancellables)
    }
    
}
