//
//  ProductListCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

protocol ProductListCellDelegate: class {
    func didRequestToAddToCart()
}

class ProductListCell: UICollectionViewCell {
    weak var delegate: ProductListCellDelegate!
    
    static let reuseID = "ProductListCell"
    
    private let containerView       = UIView()
    private let imageView           = FLRegularImageView(frame: .zero)
    private let titleLabel          = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let descriptionLabel    = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let saleLabel           = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let priceLabel          = FLTitleLabel(textAlignment: .right, fontSize: 16, textColor: FLColors.red, fontWeight: .regular)
    private let button              = FLButton()
    
    var onReuse: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addToCartButtonTapped()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addToCartButtonTapped() {
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    
    @objc func addToCart() {
        print("!!! Add to Cart")
        delegate.didRequestToAddToCart()
    }
    
    
    
    func set(product: Product) {
        imageView.downloadImage(fromURL: product.imageURL)
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        
        saleLabel.text = "月售\(Int(product.sale))件"
        
        let priceStr = String(format: "%.2f", product.price)
        priceLabel.text = "$\(priceStr)"
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, descriptionLabel, priceLabel, saleLabel, button)

        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        button.setBackgroundImage(FLImages.addToCartWithSymbol, for: .normal)
        
        containerView.pinToEdges(of: contentView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 69),
            imageView.widthAnchor.constraint(equalToConstant: 53),
            
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -9),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: 85),
            button.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 11),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor),

            saleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -9),
            saleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            saleLabel.heightAnchor.constraint(equalToConstant: 17),
            saleLabel.widthAnchor.constraint(equalToConstant: 100),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            priceLabel.heightAnchor.constraint(equalToConstant: 22),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 17),
        ])
    }
}
