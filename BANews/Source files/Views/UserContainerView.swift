//
//  UserContainerView.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import UIKit

final class UserContainerView: UIView {
    
    // MARK: - Properties
    
    var addressClickedAction: (() -> Void)?
    var emailClickedAction: (() -> Void)?
    var phoneClickedAction: (() -> Void)?
    
    // MARK: - Private properties
    
    private static let imageViewSize: CGFloat = 64
    private static let photoURL = "https://source.unsplash.com/collection/542909/?sig="

    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = UserContainerView.imageViewSize/2
        imageView.addConstraints {[
            $0.equalConstant(.height, UserContainerView.imageViewSize),
            $0.equalConstant(.width, UserContainerView.imageViewSize)
        ]}
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var emailHintLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.PostDetails.email
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(email)))
        return label
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailHintLabel,
            emailLabel
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var addressHintLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.PostDetails.address
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var streetAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var cityAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var zipCodeAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var addressDetailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            streetAddressLabel,
            cityAddressLabel,
            zipCodeAddressLabel
        ])
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(address)))
        return stackView
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            addressHintLabel,
            addressDetailsStackView
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var phoneHintLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.PostDetails.phone
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phone)))
        return label
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            phoneHintLabel,
            phoneLabel
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var companyHintLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.PostDetails.company
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var companyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            companyHintLabel,
            companyLabel
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            addressStackView,
            phoneStackView,
            companyStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
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
            userImageView,
            detailsStackView
        )
        
        userImageView.addConstraints { [
            $0.equal(.top, constant: 9.5),
            $0.equal(.leading, constant: 20)
        ] }
        
        detailsStackView.addConstraints { [
            $0.equal(.top, constant: 9.5),
            $0.equalTo(userImageView, .leading, .trailing, constant: 10),
            $0.equal(.trailing, constant: -20),
            $0.equal(.bottom, constant: -10)
        ] }
    }
    
    @objc private func address() {
        addressClickedAction?()
    }
    
    @objc private func email() {
        emailClickedAction?()
    }
    
    @objc private func phone() {
        phoneClickedAction?()
    }
    
    // MARK: - Methods
    
    func setUpView(
        userId: Int,
        username: String,
        email: String,
        street: String,
        city: String,
        zipCode: String,
        phone: String,
        company: String
    ) {
        let url = URL(string: "\(UserContainerView.photoURL))\(userId)")
        userImageView.setImage(withURL: url)
        usernameLabel.text = username
        emailLabel.text = email
        streetAddressLabel.text = street
        cityAddressLabel.text = city
        zipCodeAddressLabel.text = zipCode
        phoneLabel.text = phone
        companyLabel.text = company
        
        emailLabel.underline()
        streetAddressLabel.underline()
        cityAddressLabel.underline()
        zipCodeAddressLabel.underline()
        phoneLabel.underline()
    }
}
