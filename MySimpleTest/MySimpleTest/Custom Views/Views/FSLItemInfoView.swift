//
//  FSLItemInfoView.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 17/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit

class FSLItemInfoView: UIView {

    var itemNumber: Int!
    var itemImageViews:[FLIconImage]!
    var itemInfoLabels:[FLTitleLabel]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.itemNumber = 0
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(itemNumber: Int, labelText: [String], imageNamed: [String]) {
        super.init(frame: .zero)
        self.itemNumber = itemNumber
        configure()
    }
    
    private func configure() {
        if self.itemNumber == 0 { return }
        
        for index in 0...self.itemNumber {
            itemInfoLabels.append(FLTitleLabel(textAlignment: .left, fontSize: 16))
            itemImageViews.append(FLIconImage(frame: .zero))
            
            addSubview(itemInfoLabels[index])
            addSubview(itemImageViews[index])
            
            itemInfoLabels[index].translatesAutoresizingMaskIntoConstraints = false
            itemImageViews[index].translatesAutoresizingMaskIntoConstraints = false
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    itemImageViews[index].topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(20*(index + 1))),
                    itemImageViews[index].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                    itemImageViews[index].widthAnchor.constraint(equalToConstant: 20),
                    itemImageViews[index].heightAnchor.constraint(equalToConstant: 20),
                    
                    itemInfoLabels[index].topAnchor.constraint(equalTo: itemImageViews[index].topAnchor),
                    itemInfoLabels[index].leadingAnchor.constraint(equalTo: itemImageViews[index].trailingAnchor, constant: CGFloat(20*(index + 1))),
                    itemInfoLabels[index].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                    itemInfoLabels[index].heightAnchor.constraint(equalToConstant: 20),
                ])
            } else {
                NSLayoutConstraint.activate([
                    itemImageViews[index].topAnchor.constraint(equalTo: itemImageViews[index - 1].topAnchor, constant: CGFloat(20*(index + 1))),
                    itemImageViews[index].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                    itemImageViews[index].widthAnchor.constraint(equalToConstant: 20),
                    itemImageViews[index].heightAnchor.constraint(equalToConstant: 20),
                    
                    itemInfoLabels[index].topAnchor.constraint(equalTo: itemImageViews[index].topAnchor),
                    itemInfoLabels[index].leadingAnchor.constraint(equalTo: itemImageViews[index].trailingAnchor, constant: 20),
                    itemInfoLabels[index].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                    itemInfoLabels[index].heightAnchor.constraint(equalToConstant: 20),
                ])
            }
        }
    }
}
