//
//  UIView+Subviews.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

extension UIView {
    
    /// Shorthand method for adding multiple views.
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
