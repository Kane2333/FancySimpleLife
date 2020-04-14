//
//  FLEmptyStateView.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/14.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLEmptyStateView: UIView {
    
    let messageLabel  = FLTitleLabel(textAlignment: .center, fontSize: 14, textColor: FLColors.gray, fontWeight: .regular)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configureUI() {
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.heightAnchor.constraint(equalTo: messageLabel.heightAnchor),
            messageLabel.widthAnchor.constraint(equalTo: messageLabel.widthAnchor)
        ])
    }
}
