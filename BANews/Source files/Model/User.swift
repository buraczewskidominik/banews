//
//  User.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation

struct User: Codable, Hashable {
    let id: Int
    let name: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

struct Address: Codable, Hashable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        lhs.street == rhs.street
            && lhs.suite == rhs.suite
            && lhs.city == rhs.city
            && lhs.zipcode == rhs.zipcode
            && lhs.geo == rhs.geo
    }
}

struct Geo: Codable, Hashable {
    let lat: String
    let lng: String
}

struct Company: Codable, Hashable {
    let name: String
    let catchPhrase: String
    let bs: String
}

extension User {
    static var empty: User {
        User(
            id: 0,
            name: "",
            email: "",
            address: Address(
                        street: "",
                        suite: "",
                        city: "",
                        zipcode: "",
            geo: Geo(
                lat: "",
                lng: "")
            ),
            phone: "",
            website: "",
            company: Company(
                name: "",
                catchPhrase: "",
                bs: ""
            )
        )
    }
}
