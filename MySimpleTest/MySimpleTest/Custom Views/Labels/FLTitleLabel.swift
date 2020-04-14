//
//  FSLTitleLabel.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 16/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FLTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        font = UIFont(name:"PingFang SC", size: fontSize)
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor, fontWeight: UIFont.Weight) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        var fontName = "PingFangSC-Regular"
        if fontWeight == .medium {
            fontName = "PingFangSC-Medium"
        }
        if fontWeight == .bold {
            fontName = "PingFangSC-Bold"
        }
        self.font           = UIFont(name:fontName, size: fontSize)
        self.textColor      = textColor
    }
    
    
    private func configure() {
        text                        = "Default Label"
        textColor                   = .black
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
