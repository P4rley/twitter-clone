//
//  FeedFilter.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 02/04/24.
//

import Foundation

enum FeedFilter: Int, CaseIterable, Identifiable {
    case forYou
    case following
    
    var title: String {
        switch self {
        case .forYou:
            return "For You"
        case .following:
            return "Following"

        }
    }
    
    var id: Int { return self.rawValue }
}
