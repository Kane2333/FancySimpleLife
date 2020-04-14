//
//  ShopFilterCell.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/29.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopFilterCell: UICollectionViewCell {
    
    static let reuseID = "ShopFilterCell"
    
    private var titleLabel = FLTitleLabel(textAlignment: .center, fontSize: 14, textColor: FLColors.gray, fontWeight: .regular)
    
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font         = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor    = isSelected ? FLColors.black : FLColors.gray
            titleLabel.textAlignment = isSelected ? .justified : .center
        }
        
        
    }
 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(text: String) {
        titleLabel.text = text
    }
    /*
    
    func changeUI(isSelected: Bool) {
        titleLabel.font         = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
        titleLabel.textColor    = isSelected ? FLColors.black : FLColors.gray
        titleLabel.textAlignment = isSelected ? .justified : .center
    }
 */
    
    func configureUI() {
        backgroundColor = FLColors.white
        
        addSubview(titleLabel)
        
        titleLabel.center(of: self)
        
        pinToEdges(of: contentView)
    }
}
