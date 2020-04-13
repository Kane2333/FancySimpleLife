//
//  ProductCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCell"
    
    let imageView = FLRegularImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(shopInfo: ShopInfo, item: Int) {
        //imageView.image = nil
        imageView.downloadImage(fromURL: shopInfo.productImageURLs[item])
    }
    
    
    private func configureUI() {
        addSubview(imageView)
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 109),
            imageView.widthAnchor.constraint(equalToConstant: 109)
        ])
    }
}
