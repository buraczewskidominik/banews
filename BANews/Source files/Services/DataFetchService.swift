//
//  DataFetchService.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation
import Combine

protocol DataFetchService: AnyObject {
    func fetchPosts() -> AnyPublisher<[Post], Error>
    func fetchPost(withId id: Int) -> AnyPublisher<Post, Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
    func fetchUser(withId id: Int) -> AnyPublisher<User, Error>
}

final class DefaultDataFetchService: DataFetchService {
    
    // MARK: Private properties

    private let apiClient: APIClient
    
    // MARK: Initializers

    /// Initializes the receiver.
    /// - Parameters:
    ///   - apiClient: Client which allows connecting to the API.
    init(
        apiClient: APIClient
    ) {
        self.apiClient = apiClient
    }
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        let postsFetchRequest = PostsFetchRequest()
        return apiClient.execute(
            request: postsFetchRequest,
            answerType: [Post].self
        )
    }
    
    func fetchPost(withId id: Int) -> AnyPublisher<Post, Error> {
        let postFetchRequest = PostFetchRequest(postId: id)
        return apiClient.execute(
            request: postFetchRequest,
            answerType: Post.self
        )
    }
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        let usersFetchRequest = UsersFetchRequest()
        return apiClient.execute(
            request: usersFetchRequest,
            answerType: [User].self
        )
    }
    
    func fetchUser(withId id: Int) -> AnyPublisher<User, Error> {
        let userFetchRequest = UserFetchRequest(userId: id)
        return apiClient.execute(
            request: userFetchRequest,
            answerType: User.self
        )
    }
}
