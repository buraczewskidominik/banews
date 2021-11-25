//
//  UILabel+Underline.swift
//  BANews
//
//  Created by Dominik Buraczewski on 25/11/2021.
//

import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(
                NSAttributedString.Key.underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(
                    location: 0,
                    length: attributedString.length
                )
            )
          attributedText = attributedString
        }
    }
}
