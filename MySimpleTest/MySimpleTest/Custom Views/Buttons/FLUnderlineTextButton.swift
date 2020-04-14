//
//  FLUnderlineTextButton.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 30/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FLUnderlineTextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, titleColor: UIColor, fontSize: CGFloat) {
        self.init(frame: .zero)
        let attributeTitle = NSMutableAttributedString(string: title, attributes:
            [NSAttributedString.Key.foregroundColor: titleColor,
             NSAttributedString.Key.font: UIFont(name:"PingFang SC", size: fontSize),
                NSAttributedString.Key.underlineColor: titleColor,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])

        setAttributedTitle(attributeTitle, for: .normal)
    }
}
