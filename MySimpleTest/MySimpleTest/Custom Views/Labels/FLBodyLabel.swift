//
//  FSLBodyLabel.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 16/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    private func configure() {
        textColor                   = .secondaryLabel
        font                        = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
