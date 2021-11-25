//
//  PostDetailsViewController.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit
import Combine

protocol PostDetailsViewControllerDelegate: AnyObject {
    func sendEmail(to email: String)
    func openAddress(latitude: String, longitude: String)
    func phone(number: String)
}

final class PostDetailsViewController: ViewController {
    
    // MARK: - Properties
    
    weak var delegate: PostDetailsViewControllerDelegate?
    var viewModel: PostDetailsViewModel
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private var addressTapPublisher = PassthroughSubject<Void, Never>()
    private var emailTapPublisher = PassthroughSubject<Void, Never>()
    private var phoneTapPublisher = PassthroughSubject<Void, Never>()
    private var refreshContentPublisher = PassthroughSubject<Void, Never>()

    // MARK: UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(contentView)
        return scrollView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var contentView: UIView = {
        UIView()
    }()
    
    private lazy var userContainerView: UserContainerView = {
        let userContainerView = UserContainerView()
        userContainerView.addressClickedAction = { [weak self] in self?.addressTapPublisher.send() }
        userContainerView.emailClickedAction = { [weak self] in self?.emailTapPublisher.send() }
        userContainerView.phoneClickedAction = { [weak self] in self?.phoneTapPublisher.send() }
        return userContainerView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var postContainerView: PostContainerView = {
        PostContainerView()
    }()
    
    // MARK: - Initalizers

    init(
        viewModel: PostDetailsViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpViewModel()
    }

    private func setUpUI() {
        title = Localizable.PostDetails.details
        view.backgroundColor = .black
        view.addSubview(scrollView)
        
        scrollView.addConstraints { $0.equalEdges() }
        contentView.addConstraints { [
            $0.equal(.top),
            $0.equal(.bottom),
            $0.equalTo(view, .leading, .leading),
            $0.equalTo(view, .trailing, .trailing)
        ] }
        
        contentView.addSubviews(
            userContainerView,
            separatorView,
            postContainerView
        )
        
        userContainerView.addConstraints { [
            $0.equalTo(view, .top, .safeAreaTop),
            $0.equal(.leading),
            $0.equal(.trailing)
        ] }
        
        separatorView.addConstraints { [
            $0.equalTo(userContainerView, .top, .bottom),
            $0.equal(.leading),
            $0.equal(.trailing),
            $0.equalConstant(.height, 0.5)
        ] }
        
        postContainerView.addConstraints { [
            $0.equalTo(separatorView, .top, .bottom),
            $0.equal(.leading),
            $0.equal(.trailing),
            $0.equal(.bottom)
        ] }
    }
    
    private func setUpViewModel() {
        let (
            displayAddress,
            phoneNumber,
            presentPost,
            refreshedPost,
            sendEmail
        ) = viewModel.setUpViewModel(
            addressTapPublisher: addressTapPublisher.eraseToAnyPublisher(),
            emailTapPublisher: emailTapPublisher.eraseToAnyPublisher(),
            phoneTapPublisher: phoneTapPublisher.eraseToAnyPublisher(),
            refreshContentPublisher: refreshContentPublisher.eraseToAnyPublisher(),
            viewDidAppear: viewDidAppearPublisher
        )
        
        displayAddress
            .receive(on: RunLoop.main)
            .sink { [weak self] (latitude, longitude) in
                self?.delegate?.openAddress(latitude: latitude, longitude: longitude)
            }
            .store(in: &cancellables)
        
        phoneNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] phoneNumber in
                self?.delegate?.phone(number: phoneNumber)
            }
            .store(in: &cancellables)
        
        sendEmail
            .receive(on: RunLoop.main)
            .sink { [weak self] email in
                self?.delegate?.sendEmail(to: email)
            }
            .store(in: &cancellables)
        
        presentPost
            .receive(on: RunLoop.main)
            .sink { [weak self] post in
                self?.setUpPostDetails(post)
            }
            .store(in: &cancellables)
        
        refreshedPost
            .receive(on: RunLoop.main)
            .sink { [weak self] post in
                self?.setUpPostDetails(post)
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
    }
    
    private func setUpPostDetails(_ post: FullPost) {
        userContainerView.setUpView(
            userId: post.user.id,
            username: post.user.name,
            email: post.user.email,
            street: "\(post.user.address.suite) \(post.user.address.street)",
            city: post.user.address.city,
            zipCode: post.user.address.zipcode,
            phone: post.user.phone,
            company: post.user.company.name
        )
        postContainerView.setUpView(
            title: post.post.title,
            body: post.post.body
        )
    }
    
    @objc private func refreshContent() {
        refreshContentPublisher.send()
    }
}
