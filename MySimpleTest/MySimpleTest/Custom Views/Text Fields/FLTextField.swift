//
//  FSLTextField.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLTextField: UITextField {
    
    let leftIconView = UIImageView()
    var iconName:String!
    let padding = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 5)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(iconName: String) {
        self.init(frame: .zero)
        self.iconName = iconName
        configure()
        configureLeftIconView()
    }
    
    private func configure() {
        
        layer.cornerRadius          = 4
        //layer.borderWidth           = 2
        //layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        //textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        //backgroundColor             = .tertiarySystemBackground
        backgroundColor             = FLColors.FSLtextFieldBackgroundColor
        autocorrectionType          = .no
        returnKeyType               = .go
        autocapitalizationType      = .none
        spellCheckingType           = .no
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLeftIconView() {
        
        let padding = 20
        let size = 20

        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = UIImage(named: iconName)
        outerView.addSubview(iconView)
        outerView.backgroundColor = FLColors.FSLtextFieldBackgroundColor
        leftIconView.translatesAutoresizingMaskIntoConstraints = false
        
        leftView = outerView
        leftViewMode = .always
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
