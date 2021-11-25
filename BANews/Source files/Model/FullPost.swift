//
//  FullPost.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

struct FullPost: Hashable {
    static func == (lhs: FullPost, rhs: FullPost) -> Bool {
        lhs.post == rhs.post && lhs.user == rhs.user
    }
    
    let post: Post
    let user: User
}
