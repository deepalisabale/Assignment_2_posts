//
//  Post.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import Foundation
struct postResponse {
    var postResponse: [Post]
}

struct Post {
    var id: Int
    var title : String
    var body: String
    var userId: Int
    var tags: [String]
    var reactions: Int
}
