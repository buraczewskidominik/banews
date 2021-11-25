//
//  SplashViewController.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: Properties
    
    weak var delegate: SplashViewControllerDelegate?

    // MARK: UI
    
    private lazy var logoImageView: UIImageView = {
        UIImageView(image: UIImage.app(.splashLogo))
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.Splash.title
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.Splash.copyright
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        splash()
    }
    
    private func setUpUI() {
        view.backgroundColor = .black
        view.addSubviews(
            logoImageView,
            titleLabel,
            copyrightLabel
        )
        
        logoImageView.addConstraints { [
            $0.equal(.centerX),
            $0.equal(.top, constant: 151),
            $0.equalConstant(.height, 128),
            $0.equalConstant(.width, 128)
        ] }
        
        titleLabel.addConstraints { [
            $0.equal(.centerX),
            $0.equal(.leading, constant: 25),
            $0.equal(.trailing, constant: -25),
            $0.equalTo(logoImageView, .top, .bottom, constant: 40)
        ] }
        
        copyrightLabel.addConstraints { [
            $0.equal(.centerX),
            $0.equalTo(view, .bottom, .safeAreaBottom)
        ] }
    }
    
    private func splash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            self.delegate?.splashDidComplete(self)
        }
    }
}

// MARK: Delegate

/// A protocol which can be implemented to receive calls when splash screen completed.
protocol SplashViewControllerDelegate: AnyObject {
    
    /// Called when splash screen completed.
    ///
    /// - Parameter splashViewController: The splash view controllet.
    func splashDidComplete(_ splashViewController: SplashViewController)
}
