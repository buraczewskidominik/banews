//
//  Publisher+RxSwift.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import UIKit

extension UIView {
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loadingIndicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
        
        if loadingIndicator == nil {
            loadingIndicator = UIActivityIndicatorView(style: style)
        }
        
        guard let loadingIndicatorView = loadingIndicator else { return }
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.hidesWhenStopped = true
        addSubview(loadingIndicatorView)
        loadingIndicatorView.addConstraints { $0.equalEdges() }
    }
    
    func stopLoading() {
        let loading = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
