//
//  HomeTuanGoCell.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class HomeTuanGoCell: UICollectionViewCell {
    
    static let reuseID              = "HomeTuanGoCell"
    
    private let containerView       = UIView()
    private let imageView           = FLRegularImageView(frame: .zero)
    private let titleLabel          = FLTitleLabel(textAlignment: .center, fontSize: 14, textColor: FLColors.black, fontWeight: .regular)
    private let secondaryLabel      = FLTitleLabel(textAlignment: .center, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let amountLabel         = FLTitleLabel(textAlignment: .center, fontSize: 10, textColor: FLColors.red, fontWeight: .regular)
    private let priceLabel          = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.red, fontWeight: .regular)
    private let originalPriceLabel   = FLStrikeThroughLabel(textAlignment: .center, fontSize: 8)
    private let button              = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(tuanGoItem: TuanGo) {
        let priceStr = String(format: "%.2f", tuanGoItem.price)
        let originalPriceStr = String(format: "%.2f", tuanGoItem.originalPrice)
        imageView.downloadImage(fromURL: tuanGoItem.imageURL)
        titleLabel.text         = tuanGoItem.title
        secondaryLabel.text     = tuanGoItem.secondaryTitle
        amountLabel.text        = "剩余\(tuanGoItem.amount)件"
        priceLabel.text         = "$\(priceStr)"
        originalPriceLabel.set(text: "$\(originalPriceStr)")
    }
    
    
    private func configureUI() {
        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        button.backgroundColor              = FLColors.red
        button.tintColor                    = FLColors.white
        button.titleLabel?.font             = UIFont.systemFont(ofSize: 10, weight: .regular)
        button.layer.cornerRadius           = 17 / 2
        button.setImage(FLImages.cart, for: .normal)
        button.setTitle("马上抢", for: .normal)
        button.imageEdgeInsets              = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        button.titleEdgeInsets              = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
    }
    
    
    private func configureLayout() {
        addSubviews(containerView)
        containerView.addSubviews(imageView, titleLabel, secondaryLabel, amountLabel, priceLabel, originalPriceLabel, button)
        bringSubviewToFront(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints        = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            secondaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            secondaryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9),
            secondaryLabel.widthAnchor.constraint(equalTo: secondaryLabel.widthAnchor),
            secondaryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            amountLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            amountLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            amountLabel.widthAnchor.constraint(equalTo: amountLabel.widthAnchor),
            amountLabel.heightAnchor.constraint(equalToConstant: 14),
            
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            priceLabel.widthAnchor.constraint(equalTo: priceLabel.widthAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 19),
            
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 2),
            originalPriceLabel.widthAnchor.constraint(equalTo: originalPriceLabel.widthAnchor),
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            originalPriceLabel.heightAnchor.constraint(equalToConstant: 10),
            
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 17),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: 60),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 225),
            
        ])
    }
}
