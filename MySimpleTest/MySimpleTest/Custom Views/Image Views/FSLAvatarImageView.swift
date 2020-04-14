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
        let viewWidth = layer.frame.size.width
        let viewrHeight = layer.frame.size.height
        
        //let borderViewWidth = 146 / 2 + 30
        //let borderViewHeight = viewrHeight / 2 + 30
        
        //let borderView = UIView(frame: CGRect(x: 0, y: 0, width: borderViewWidth, height: borderViewHeight))
        //borderView.layer.cornerRadius = borderViewWidth / 2
        //borderView.clipsToBounds = true
        //borderView.layer.borderColor = UIColor.red.cgColor
        //borderView.layer.borderWidth = 5
        //addSubview(borderView)
        
        layer.cornerRadius  = 146 / 2
        clipsToBounds       = true
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 5
        image               = UIImage(named: "placeholderImage")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
