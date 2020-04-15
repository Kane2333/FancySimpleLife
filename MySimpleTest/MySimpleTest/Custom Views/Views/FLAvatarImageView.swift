//
//  FLAvatarImageView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 15/4/20.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit


class FLAvatarImageView: UIView{
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 131, height: 131))
    let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 146, height: 146))
    var imageName: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: String) {
        self.init(frame: .zero)
        imageName = image
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 131 / 2
        imageView.clipsToBounds = true
        
        outerView.layer.cornerRadius = 146 / 2
        outerView.layer.borderColor = UIColor.red.cgColor
        outerView.layer.borderWidth = 2
        
        addSubviews(imageView, outerView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        outerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 131),
            imageView.widthAnchor.constraint(equalToConstant: 131),
            
            outerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            outerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            outerView.heightAnchor.constraint(equalToConstant: 146),
            outerView.widthAnchor.constraint(equalToConstant: 146)
        ])
    }
}
