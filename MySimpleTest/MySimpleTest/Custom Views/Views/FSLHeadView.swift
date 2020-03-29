//
//  FSLHeadView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 16/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLHeadView: UIView {

    let iconImageView = UIImageView()
    let pageLabel = FLTitleLabel(textAlignment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(pageTitle: String) {
        super.init(frame: .zero)
        pageLabel.text = pageTitle
        configure()
    }
    
    // MARK: Private function
    
    private func configure() {
        backgroundColor = .black
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(pageLabel)
        pageLabel.textColor = .systemBackground
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -56),
            pageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
