//
//  FLStrikeThroughLabel.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLStrikeThroughLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    
    private func configure() {
        textColor                                   = FLColors.gray
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail // one line...
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    func set(text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }
}

