//
//  SearchCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/11.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    static let reuseID = "SearchCell"
    
    let label = FLTitleLabel(textAlignment: .center, fontSize: 12, textColor: FLColors.gray2, fontWeight: .regular)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(text: String) {
        label.text = text
    }
    
    
    private func configureUI() {
        contentView.addSubview(label)
        self.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            label.heightAnchor.constraint(equalToConstant: 17),
            label.widthAnchor.constraint(equalTo: label.widthAnchor)
        ])
    }
    
}
