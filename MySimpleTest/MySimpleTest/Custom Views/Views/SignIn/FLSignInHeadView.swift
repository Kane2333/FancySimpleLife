//
//  FSLSignInHeadView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 28/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLSignInHeadView: UIView {

    let welcomeLabel = FLTitleLabel(textAlignment: .left, fontSize: 24)
    let avatarImageView = FSLAvatarImageView(frame: .zero)
    var welcomeText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        
        welcomeText = text
        
        configure()
        configureAvatarImageView()
        configureWelcomeLabel()
    }
    
    private func configure() {
        backgroundColor = FLColors.FSLbackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(welcomeLabel, avatarImageView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 70),
            
            avatarImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 146),
            avatarImageView.widthAnchor.constraint(equalToConstant: 146),
        ])
    }
    
    private func configureWelcomeLabel() {
        welcomeLabel.numberOfLines = 2
        welcomeLabel.text = welcomeText
    }

    private func configureAvatarImageView() {
        
    }
}
