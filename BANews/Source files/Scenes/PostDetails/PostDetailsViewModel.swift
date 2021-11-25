//
//  PostDetailsViewModel.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import Foundation
import Combine

final class PostDetailsViewModel: NSObject {
    
    private var post: FullPost
    private let dataStorage: DataStorage
    private let dataFetchService: DataFetchService
    
    init(
        post: FullPost,
        dataStorage: DataStorage,
        dataFetchService: DataFetchService
    ) {
        self.post = post
        self.dataStorage = dataStorage
        self.dataFetchService = dataFetchService
    }
    
    func setUpViewModel(
        addressTapPublisher: AnyPublisher<Void, Never>,
        emailTapPublisher: AnyPublisher<Void, Never>,
        phoneTapPublisher: AnyPublisher<Void, Never>,
        refreshContentPublisher: AnyPublisher<Void, Never>,
        viewDidAppear: AnyPublisher<Void, Never>
    ) -> (
        displayAddress: AnyPublisher<(String, String), Never>,
        phoneNumber: AnyPublisher<String, Never>,
        presentPost: AnyPublisher<FullPost, Never>,
        refreshedPost: AnyPublisher<FullPost, Never>,
        sendEmail: AnyPublisher<String, Never>
    ) {
        let displayAddress = addressTapPublisher
            .map { Void -> (String, String) in
                let geo = self.post.user.address.geo
                return (geo.lat, geo.lng)
            }
            .eraseToAnyPublisher()
        
        let phoneNumber = phoneTapPublisher
            .map { Void -> String in
                self.post.user.phone
            }
            .eraseToAnyPublisher()
        
        let sendEmail = emailTapPublisher
            .map { Void -> String in
                self.post.user.email
            }
            .eraseToAnyPublisher()
        
        let fetchedPost = dataFetchService
            .fetchPost(withId: post.post.id)
            .zip(dataFetchService.fetchUser(withId: post.post.userId))
            .map { post, user -> FullPost in
                self.dataStorage.savePost(post)
                self.dataStorage.saveUser(user)
                
                let newFullPost = FullPost(
                    post: post,
                    user: user
                )
                
                self.post = newFullPost
                
                return newFullPost
            }
            .share()
        
        let presentPost = viewDidAppear
            .map { Void -> FullPost in
                self.post
            }
            .eraseToAnyPublisher()
        
        let post = fetchedPost
            .replaceError(
                with:
                    FullPost(
                        post: Post.empty,
                        user: User.empty
                    )
            )
            .eraseToAnyPublisher()
        
        let refreshedPost = refreshContentPublisher
            .withLatestFrom(post) { $1 }
            .eraseToAnyPublisher()
        
        return (
            displayAddress: displayAddress,
            phoneNumber: phoneNumber,
            presentPost: presentPost,
            refreshedPost: refreshedPost,
            sendEmail: sendEmail
        )
    }
}
