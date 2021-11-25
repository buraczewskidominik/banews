//
//  PostContainerView.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import UIKit

final class PostContainerView: UIView {    
    
    // MARK: - Private properties

    private lazy var fullTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var fullBodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullBodyLabel])
        stackView.alignment = .top
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setUpUI() {
        addSubviews(
            fullTitleLabel,
            bodyStackView
        )
        
        fullTitleLabel.addConstraints { [
            $0.equal(.top, constant: 10),
            $0.equal(.leading, constant: 20),
            $0.equal(.trailing, constant: -20)
        ] }
        
        bodyStackView.addConstraints { [
            $0.equalTo(fullTitleLabel, .top, .bottom, constant: 8),
            $0.equal(.leading, constant: 20),
            $0.equal(.trailing, constant: -20),
            $0.equal(.bottom, constant: -16)
        ] }
    }
    
    // MARK: - Methods
    
    func setUpView(
        title: String,
        body: String
    ) {
        fullTitleLabel.text = title
        fullBodyLabel.text = body
    }
}
