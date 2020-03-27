//
//  FLAlertContainerView.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLAlertContainerView: UIView {

   override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        self.backgroundColor = FLColors.white
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = FLColors.white.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
