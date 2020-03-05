//
//  FSLTextField.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLTextField: UITextField {

    var placeHolderText:String?
    var defaultPlaceHolderText: String = "Default placeholder text."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(placeHolderText: defaultPlaceHolderText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolderText: String, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        configure(placeHolderText: placeHolderText)
    }
    
    private func configure(placeHolderText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = textAlignment
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
        placeholder                 = placeHolderText
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
