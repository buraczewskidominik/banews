//
//  UserFetchRequest.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

struct UserFetchRequest: Request {
    
    // MARK: Properties

    // - SeeAlso: Request.path
    var path: String {
        "/users/\(userId)"
    }

    // - SeeAlso: Request.method
    var method: HTTPMethod {
        .get
    }
    
    // MARK: Private properties

    private let userId: Int

    // MARK: Initializers

    /// Initializes the receiver.
    /// - Parameters:
    ///   - userId: User's id.
    init(userId: Int) {
        self.userId = userId
    }
}
