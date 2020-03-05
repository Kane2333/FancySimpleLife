//
//  FSLButton.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import GoogleSignIn

class FSLButton: UIButton {

    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundImage: UIImage? = nil, title: String, titleColor: UIColor, titleHorizontalAlignment: ContentHorizontalAlignment)
    {
        super.init(frame:. zero)
        if backgroundImage != nil {
            self.setBackgroundImage(backgroundImage, for: .normal)
        }
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.contentHorizontalAlignment = titleHorizontalAlignment
        configure()
    }
    
    // MARK: Private Method
    
    private func configure() {
        //layer.cornerRadius = 10
        //setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
