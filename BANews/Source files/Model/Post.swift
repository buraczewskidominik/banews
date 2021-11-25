//
//  Post.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation

struct Post: Decodable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    static var empty: Post {
        Post(
            userId: 0,
            id: 0,
            title: "",
            body: ""
        )
    }
}
