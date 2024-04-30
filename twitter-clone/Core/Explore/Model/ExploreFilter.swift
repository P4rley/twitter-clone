//
//  ExploreFilter.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 23/04/24.
//

import Foundation

enum ExploreFilter: Int, CaseIterable, Identifiable {
    case forYou
    case trending
    case news
    case sports
    case entertaiment
    
    var title: String {
        switch self {
        case .forYou:
            return "For You"
        case .trending:
            return "Trending"
        case .news:
            return "News"
        case .sports:
            return "Sports"
        case .entertaiment:
            return "Entertaiment"

        }
    }
    
    var id: Int { return self.rawValue }
}
