//
//  APIError.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation

enum APIError: Error {
    case malformedResponseJson
    case commonError
    case noData
}
