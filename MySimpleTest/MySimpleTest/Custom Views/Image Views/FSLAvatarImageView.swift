//
//  FSLAvatarImageView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 28/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = UIImage(named: "placeholderImage")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
