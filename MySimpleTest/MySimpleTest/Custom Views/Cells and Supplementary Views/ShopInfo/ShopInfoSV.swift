//
//  ShopInfoSV.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopInfoSV: UICollectionReusableView {
    
    static let reuseID  = "ShopInfoSV"
    
    private let titleLabel      = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.black, fontWeight: .medium)
    private let countLabel      = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.black, fontWeight: .regular)
    private let button          = FLButton(title: "更多", textColor: FLColors.red, fontSize: 12)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func set(title: String, hasButton: Bool, commentCount: Int?=nil) {
        titleLabel.text = title
        
        if hasButton {
           addSubview(button)
            
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 5),
                button.heightAnchor.constraint(equalTo: button.heightAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
                button.widthAnchor.constraint(equalTo: button.widthAnchor)
            ])
        }
        
        if commentCount != nil {
            addSubview(countLabel)
            countLabel.text = "(\(Int(commentCount!))条"
            
            NSLayoutConstraint.activate([
                countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 7),
                countLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                countLabel.heightAnchor.constraint(equalToConstant: 17),
                countLabel.widthAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    
    
    private func configure() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),

        ])
    }
}
