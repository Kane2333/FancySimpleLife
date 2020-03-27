//
//  HomeTuanGoSV.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class HomeTuanGoSV: UICollectionReusableView {
    
    static let reuseID  = "HomeTuanGoSV"
    
    private let label   = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.black, fontWeight: .medium)
    private let button  = FLTextButton(title: "更多")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubViews(label, button)
        
        label.text = "团购"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            label.widthAnchor.constraint(equalTo: label.widthAnchor),
            
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 5),
            button.heightAnchor.constraint(equalTo: button.heightAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            button.widthAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
}
