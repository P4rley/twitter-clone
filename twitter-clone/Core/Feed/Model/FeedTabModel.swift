//
//  FeedFilter.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 02/04/24.
//

import Foundation

struct FeedTabModel: Identifiable {
    private(set) var id: Tab
    
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case forYou = "For You"
        case following = "Following"

    }
}
