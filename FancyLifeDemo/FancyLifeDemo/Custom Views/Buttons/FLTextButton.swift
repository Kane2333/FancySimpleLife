//
//  FLTextButton.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLTextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        //backgroundColor                             = FLColors.white
        setTitleColor(FLColors.red, for: .normal)
        titleLabel?.textAlignment                   = .center
        translatesAutoresizingMaskIntoConstraints   = false
        titleLabel?.font                            = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

}
