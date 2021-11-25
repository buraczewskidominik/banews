//
//  PostListViewController.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit
import Combine

protocol PostListViewControllerDelegate: AnyObject {
    func willOpenPostDetails(_ post: FullPost)
    func displayError(_ error: String)
}

final class PostListViewController: ViewController {
    
    // MARK: - Properties
    
    weak var delegate: PostListViewControllerDelegate?
    var viewModel: PostListViewModel
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private var cellTapPublisher = PassthroughSubject<Int, Never>()
    private var refreshContentPublisher = PassthroughSubject<Void, Never>()

    // MARK: UI
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .darkGray
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.addSubview(refreshControl)
        return tableView
    }()
    
    // MARK: - Datasource
    
    enum Section {
        case main
    }
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, FullPost>(tableView: postsTableView) { tableView, indexPath, fullPost in
        let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell
        postCell?.setUpContent(
            username: fullPost.user.name,
            companyName: fullPost.user.company.name,
            postTitle: fullPost.post.title,
            postBody: fullPost.post.body
        )
        return postCell
    }
    
    // MARK: - Initalizers

    init(
        viewModel: PostListViewModel
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
        refreshContentPublisher.send()
    }
    
    private func setUpUI() {
        title = Localizable.PostList.list
        view.backgroundColor = .black
        view.addSubviews(
            postsTableView
        )
        
        postsTableView.dataSource = dataSource
        postsTableView.addConstraints { $0.equalSafeAreaEdges() }
    }
    
    private func setUpViewModel() {
        let (
            displayError,
            presentPostDetails,
            presentPosts
        ) = viewModel.setUpViewModel(
            cellTapPublisher: cellTapPublisher.eraseToAnyPublisher(),
            refreshContentPublisher: refreshContentPublisher.eraseToAnyPublisher(),
            viewDidAppear: viewDidAppearPublisher
        )
        
        displayError
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                self?.delegate?.displayError(error)
            }
            .store(in: &cancellables)
        
        presentPostDetails
            .receive(on: RunLoop.main)
            .sink { [weak self] post in
                self?.delegate?.willOpenPostDetails(post)
            }
            .store(in: &cancellables)

        presentPosts
            .receive(on: RunLoop.main)
            .sink { [weak self] posts in
                self?.applySnapshot(for: posts)
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
    }
    
    @objc private func refreshContent() {
        refreshContentPublisher.send()
    }
    
    private func applySnapshot(for posts: [FullPost], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FullPost>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot, animatingDifferences: animated, completion: nil)
    }
}

// MARK: - UITableViewDelegate methods

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapPublisher.send(indexPath.row)
    }
}
