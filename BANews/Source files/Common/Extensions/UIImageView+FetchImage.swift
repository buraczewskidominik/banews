//
//  Publisher+RxSwift.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import UIKit

extension UIImageView {
    
    /// Set image from network.
    ///
    /// - Parameter url: the url of the image.
    func setImage(withURL url: URL?) {
        guard let url = url else { return }

        self.showLoading()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer {
                DispatchQueue.main.async {
                    self?.stopLoading()
                }
            }

            guard let pictureData = try? Data(contentsOf: url) else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: pictureData)
                self?.image = image
            }
        }
    }
}
