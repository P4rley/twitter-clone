//
//  Tweet.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 28/05/24.
//

import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Codable {
    @DocumentID var tweetId: String?
    
    let ownerUid: String
    let caption: String
    let picture: String
    let timestamp: Timestamp
    var likes: Int
    
    var id: String {
        return tweetId ?? NSUUID().uuidString
    }
    
    var user: User?
}
