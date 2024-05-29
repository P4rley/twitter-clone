//
//  ProfileFilter.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 13/05/24.
//

import Foundation

struct ProfileTabModel: Identifiable {
    private(set) var id: Tab
    
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case posts = "Posts"
        case replies = "Replies"
        case highlights = "Highlights"
        case articles = "Articels"
        case media = "Media"
        case likes = "Likes"
    }
}


//enum ProfileFilter: String, CaseIterable, Identifiable {
//    case posts
//    case replies
//    case highlights
//    case articles
//    case media
//    case likes
//    
//    var title: String {
//        switch self {
//        case .posts:
//            return "Posts"
//        case .replies:
//            return "Replies"
//        case .highlights:
//            return "Highlights"
//        case .articles:
//            return "Articles"
//        case .media:
//            return "Media"
//        case .likes:
//            return "Likes"
//        }
//    }
//    
//    var id: String { return self.rawValue }
//    
//    var size: CGSize { return .zero}
//    var minX: CGFloat { return .zero }
//}
