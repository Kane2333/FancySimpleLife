//
//  FSLButton.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import GoogleSignIn

class FLButton: UIButton {

    override init(frame:CGRect) {
        super.init(frame: frame)
        translateConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, textColor: UIColor, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    convenience init(backgroundColor: UIColor, title: String, titleColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        configure()
    }
    
    convenience init(image: UIImage? = nil, title: String) {
        self.init(frame:. zero)
        configure()
        if backgroundImage != nil {
            self.setImage(image, for: .normal)
        }
        self.setTitle(title, for: .normal)
    }
    
    // MARK: Private Method
    
    private func configure() {
        layer.cornerRadius                  = 4
        //layer.borderWidth                 = 2
        layer.borderColor                   = UIColor.systemGray4.cgColor
        titleLabel?.textAlignment           = .center
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
    }
    
    private func translateConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
