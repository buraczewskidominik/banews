//
//  Coordinator.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation

protocol Coordinator: AnyObject {
    
    /// Method triggered when new coordinator starts its life.
    func start()
}
