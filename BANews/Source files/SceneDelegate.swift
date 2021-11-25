//
//  SceneDelegate.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Properties

    var window: UIWindow?
    
    // MARK: Private properties

    private let appDependencies = AppDependencies()
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        decorateNavigationBar()
        startApp(withWindowScene: windowScene)
    }
    
    private func startApp(withWindowScene windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(
            window: window,
            appDependencies: appDependencies
        )
        appCoordinator?.start()
    }
    
    private func decorateNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearace.barTintColor = .black
        navigationBarAppearace.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearace.shadowImage = UIImage()
    }
}
