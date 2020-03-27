//
//  FSLTextLabel.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 6/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLTextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat, text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
