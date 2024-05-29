//
//  User.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    let dateOfBirth: String
    var profileImageUrl: String?
    var bio: String?
    
}
