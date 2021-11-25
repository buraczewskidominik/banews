//
//  PostListViewModel.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation
import Combine

final class PostListViewModel: NSObject {
    
    private var currentFullPosts = [FullPost]()
    private let dataStorage: DataStorage
    private let dataFetchService: DataFetchService
    
    init(
        dataStorage: DataStorage,
        dataFetchService: DataFetchService
    ) {
        self.dataStorage = dataStorage
        self.dataFetchService = dataFetchService
    }
    
    func setUpViewModel(
        cellTapPublisher: AnyPublisher<Int, Never>,
        refreshContentPublisher: AnyPublisher<Void, Never>,
        viewDidAppear: AnyPublisher<Void, Never>
    ) -> (
        displayError: AnyPublisher<String, Never>,
        presentPostDetails: AnyPublisher<FullPost, Never>,
        presentPosts: AnyPublisher<[FullPost], Never>
    ) {        
        let fetchedPosts = dataFetchService
            .fetchPosts()
            .zip(dataFetchService.fetchUsers())
            .map { posts, users -> [FullPost] in
                posts.forEach { self.dataStorage.savePost($0) }
                users.forEach { self.dataStorage.saveUser($0) }
                
                posts.forEach {
                    let postUserId = $0.userId
                    guard let user = users.first(where: { $0.id == postUserId }) else { return }
                    let newFullPost = FullPost(
                        post: $0,
                        user: user
                    )
                    self.currentFullPosts.append(newFullPost)
                }

                return self.currentFullPosts
            }
            .share()
        
        let displayError = fetchedPosts
            .mapError({ $0 as Error })
            .flatMap({ output -> AnyPublisher<String, Never> in
                Just(output.description).eraseToAnyPublisher()
            })
            .catch({ error in
                Just(error.localizedDescription)
            })
            .eraseToAnyPublisher()
        
        let posts = fetchedPosts
            .replaceError(with: [FullPost]())
            .share()
        
        let presentPostDetails = cellTapPublisher
            .map { cellRow -> FullPost in
                self.currentFullPosts[cellRow]
            }
            .eraseToAnyPublisher()
        
        let presentPosts = viewDidAppear
            .combineLatest(refreshContentPublisher)
            .withLatestFrom(posts) { $1 }
            .eraseToAnyPublisher()
        
        return (
            displayError: displayError,
            presentPostDetails: presentPostDetails,
            presentPosts: presentPosts
        )
    }
}
