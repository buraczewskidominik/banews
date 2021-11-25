//
//  AppCoordinator.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit
import MessageUI

/// A coordinator for core app navigation.
final class AppCoordinator: Coordinator {
    
    // MARK: Private properties
    
    private let window: UIWindow
    private let appDependencies: AppDependencies
    
    private var navigationController: UINavigationController?
    
    /// Initialize an AppCoordinator for the given window.
    ///
    /// - Parameters:
    ///   - window: The window for the coordinator to use.
    ///   - appDependencies: The app dependencies container.
    init(window: UIWindow, appDependencies: AppDependencies) {
        self.window = window
        self.appDependencies = appDependencies
        window.makeKeyAndVisible()
    }
    
    func start() {
        showSplash()
    }
    
    private func showSplash() {
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        window.rootViewController = splashViewController
    }
    
    private func showPostList() {
        let postListViewModel = PostListViewModel(
            dataStorage: appDependencies.dataStorage,
            dataFetchService: appDependencies.dataService
        )
        let postListViewController = PostListViewController(viewModel: postListViewModel)
        postListViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: postListViewController)
        self.navigationController = navigationController
        transition(to: navigationController)
    }
    
    private func showPostDetails(_ post: FullPost) {
        let postDetailsViewModel = PostDetailsViewModel(
            post: post,
            dataStorage: appDependencies.dataStorage,
            dataFetchService: appDependencies.dataService
        )
        let postDetailsViewController = PostDetailsViewController(viewModel: postDetailsViewModel)
        postDetailsViewController.delegate = self
        navigationController?.pushViewController(postDetailsViewController, animated: true)
    }
    
    private func presentMailSender(for email: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.setToRecipients([email])
        navigationController?.present(mailComposeViewController, animated: true)
    }
    
    private func presentError(_ error: String) {
        let alert = UIAlertController(
            title: Localizable.ErrorAlert.error,
            message: error,
            preferredStyle: .alert
        )
        navigationController?.present(alert, animated: true)
    }
}

extension AppCoordinator {
    private func transition(to viewController: UIViewController) {
        viewController.view.backgroundColor = .white
        let snapshot = window.snapshotView(afterScreenUpdates: false)
        window.rootViewController = viewController
        if let snapshot = snapshot {
            viewController.view.addSubview(snapshot)
            UIView.animate(withDuration: 0.3,
                           animations: { snapshot.alpha = 0 },
                           completion: { _ in snapshot.removeFromSuperview() }
            )
        }
    }
}

// MARK: SplashViewControllerDelegate methods

extension AppCoordinator: SplashViewControllerDelegate {
    func splashDidComplete(_ splashViewController: SplashViewController) {
        showPostList()
    }
}

// MARK: PostListViewControllerDelegate methods

extension AppCoordinator: PostListViewControllerDelegate {
    func willOpenPostDetails(_ post: FullPost) {
        showPostDetails(post)
    }
    
    func displayError(_ error: String) {
        presentError(error)
    }
}

// MARK: PostDetailsViewControllerDelegate methods

extension AppCoordinator: PostDetailsViewControllerDelegate {
    func sendEmail(to email: String) {
        presentMailSender(for: email)
    }
    
    func openAddress(latitude: String, longitude: String) {
        guard let url = URL(string: "comgooglemaps://?center=\(latitude),\(longitude)") else { return }
        UIApplication.shared.open(url)
    }
    
    func phone(number: String) {
        guard let url = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(url)
    }
}
