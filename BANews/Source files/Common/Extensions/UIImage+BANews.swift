//
//  UIImage+BANews.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

extension UIImage {
    
    enum AppImage {
        case splashLogo
    }

    static func app(_ image: AppImage) -> UIImage? {
        switch image {
        case .splashLogo:
            return UIImage(named: "SplashLogo")
        }
    }
}
