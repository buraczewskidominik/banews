//
//  PostCell.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

final class PostCell: UITableViewCell {

    // MARK: Properties
    
    static let identifier = "PostCell"
        
    // MARK: Private properties
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private lazy var postBodyLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    private func setUpUI() {
        contentView.backgroundColor = .black
        contentView.addSubviews(
            usernameLabel,
            companyNameLabel,
            postTitleLabel,
            postBodyLabel
        )
        
        usernameLabel.addConstraints { [
            $0.equal(.top, constant: 9),
            $0.equal(.leading, constant: 20)
        ] }
        
        companyNameLabel.addConstraints { [
            $0.equalTo(usernameLabel, .leading, .trailing, constant: 8),
            $0.equalTo(usernameLabel, .centerY, .centerY),
            $0.equal(.trailing, constant: -20)
        ] }
        
        postTitleLabel.addConstraints { [
            $0.equalTo(usernameLabel, .top, .bottom, constant: 12),
            $0.equal(.leading, constant: 20),
            $0.equal(.trailing)
        ] }
        
        postBodyLabel.addConstraints { [
            $0.equalTo(postTitleLabel, .top, .bottom, constant: 8),
            $0.equal(.leading, constant: 20),
            $0.equal(.trailing),
            $0.equal(.bottom, constant: -10)
        ] }
    }
    
    func setUpContent(
        username: String,
        companyName: String,
        postTitle: String,
        postBody: String
    ) {
        usernameLabel.text = username
        companyNameLabel.text = companyName
        postTitleLabel.text = postTitle
        postBodyLabel.text = postBody
    }
}
