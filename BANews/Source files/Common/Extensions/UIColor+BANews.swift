//
//  UIColor+BANews.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

extension UIColor {
    
    enum AppColor {
        case background
    }

    static func app(_ color: AppColor) -> UIColor {
        switch color {
        case .background:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
