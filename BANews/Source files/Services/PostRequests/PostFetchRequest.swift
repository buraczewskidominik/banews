//
//  PostFetchRequest.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

struct PostFetchRequest: Request {
    
    // MARK: Properties

    // - SeeAlso: Request.path
    var path: String {
        "/posts/\(postId)"
    }

    // - SeeAlso: Request.method
    var method: HTTPMethod {
        .get
    }
    
    // MARK: Private properties

    private let postId: Int

    // MARK: Initializers

    /// Initializes the receiver.
    /// - Parameters:
    ///   - postId: Post id.
    init(postId: Int) {
        self.postId = postId
    }
}
