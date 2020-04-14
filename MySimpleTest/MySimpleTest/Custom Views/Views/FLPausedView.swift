//
//  FLloadingView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 14/4/20.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLPausedView: UIView {

    let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(imageNamed: String) {
        self.init(frame: .zero)
        self.imageView.image = UIImage(named: imageNamed)
        configure()
    }
    
    
    private func configure() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 124),
            imageView.widthAnchor.constraint(equalToConstant: 124)
        ])
    }

}
