//
//  PostsFetchRequest.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

struct PostsFetchRequest: Request {
    
    // MARK: Properties

    // - SeeAlso: Request.path
    var path: String {
        "/posts"
    }

    // - SeeAlso: Request.method
    var method: HTTPMethod {
        .get
    }
}
