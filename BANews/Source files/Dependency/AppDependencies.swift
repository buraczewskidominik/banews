//
//  AppDependencies.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation

/// A holder for dependencies used in the app.
final class AppDependencies {
    
    // MARK: Storage
    
    lazy var dataStorage = DefaultDataStorage()
    
    // MARK: Network
    
    private lazy var apiClient = DefaultAPIClient()
    
    // MARK: Service
    
    /// Service providing communication with the server.
    lazy var dataService = DefaultDataFetchService(apiClient: apiClient)
}
