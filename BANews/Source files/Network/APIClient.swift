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
        Deferred {
            Future { promise in
                let urlRequest = request.asURLRequest()
                let task = self.defaultUrlSession.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
                    if error != nil {
                        promise(.failure(APIError.commonError))
                    }
                    
                    if let self = self,
                       let response = urlResponse as? HTTPURLResponse,
                       let data = data {
                        let result = self.mapResponse(
                            response: response,
                            data: data,
                            answerType: answerType
                        )
                        switch result {
                        case .success(let mappedData):
                            promise(.success(mappedData))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
                }
                task.resume()
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: Private methods
    
    private func mapResponse<DataType: Decodable>(
        response: HTTPURLResponse,
        data: Data,
        answerType: DataType.Type
    ) -> Result<DataType, Error> {
        switch response.statusCode {
        case 200:
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(DataType.self, from: data) {
                return .success(decodedData)
            } else {
                return .failure(APIError.malformedResponseJson)
            }
        default:
            return .failure(APIError.commonError)
        }
    }
}
