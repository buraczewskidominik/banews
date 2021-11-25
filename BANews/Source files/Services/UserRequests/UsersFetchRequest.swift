//
//  UsersFetchRequest.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

struct UsersFetchRequest: Request {
    
    // MARK: Properties

    // - SeeAlso: Request.path
    var path: String {
        "/users"
    }

    // - SeeAlso: Request.method
    var method: HTTPMethod {
        .get
    }
}
