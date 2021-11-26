//
//  APIClient.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Combine
import Foundation

protocol APIClient: AnyObject {
    
    func execute<DataType: Decodable>(
        request: Request,
        answerType: DataType.Type
    ) -> AnyPublisher<DataType, Error>
}

final class DefaultAPIClient: NSObject, APIClient {
    
    // MARK: Private properties

    private let defaultUrlSession = URLSession(configuration: .default)

    // MARK: Methods

    /// Executes url request.
    ///
    /// - Parameters:
    ///   - request: request to be performed.
    ///   - dataType: data type of the response.
    func execute<DataType: Decodable>(
        request: Request,
        answerType: DataType.Type
    ) -> AnyPublisher<DataType, Error> {
        defaultUrlSession
            .dataTaskPublisher(for: request.asURLRequest())
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: answerType, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
