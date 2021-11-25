//
//  ViewController.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var viewDidAppearPublisher: AnyPublisher<Void, Never> {
        viewDidAppearSubject.eraseToAnyPublisher()
    }

    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send()
    }
}
