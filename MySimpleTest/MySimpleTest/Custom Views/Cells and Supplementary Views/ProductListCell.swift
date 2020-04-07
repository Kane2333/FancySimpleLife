//
//  ProductCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCell"
    
    private let containerView       = UIView()
    private let imageView           = FLRegularImageView(frame: .zero)
    private let titleLabel          = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let descriptionLabel  = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let saleLabel           = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let priceLabel          = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.red, fontWeight: .regular)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(imageURL: String, title: String, description: String, sale: Double, price: Double) {
        imageView.downloadImage(fromURL: imageURL)
        titleLabel.text = title
        descriptionLabel.text = description
        
        saleLabel.text = "\(Int(sale))"
        
        let priceStr = String(format: "%.2f", price)
        priceLabel.text = "$\(priceStr)"
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, descriptionLabel, priceLabel)

        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        starSymbol.image                = FLImages.star
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.pinToEdges(of: contentView)
        starSymbol.translatesAutoresizingMaskIntoConstraints    = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 69),
            imageView.widthAnchor.constraint(equalToConstant: 53),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 11),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -100),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 17),
            
            saleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -9),
            saleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            saleLabel.heightAnchor.constraint(equalToConstant: 17),
            saleLabel.widthAnchor.constraint(equalToConstant: 100),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            priceLabel.heightAnchor.constraint(equalToConstant: 22),
            priceLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
