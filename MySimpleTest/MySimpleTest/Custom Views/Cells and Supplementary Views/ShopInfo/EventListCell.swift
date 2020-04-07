//
//  EventListCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class EventListCell: UICollectionViewCell {
    
    static let reuseID = "EventListCell"
    
    private let containerView           = UIView()
    private let imageView               = FLRegularImageView(frame: .zero)
    private let titleLabel              = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let descriptionLabel        = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let priceLabel              = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.red, fontWeight: .regular)
    private let originalPriceLabel      = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let button                  = FLButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(imageURL: String, title: String, description: String, price: Double, originalPrice: Double) {
        imageView.downloadImage(fromURL: imageURL)
        titleLabel.text             = title
        descriptionLabel.text       = description
        
        let priceStr                = String(format: "%.2f", price)
        let originalPriceStr        = String(format: "%.2f", originalPrice)
        priceLabel.text             = priceStr
        originalPriceLabel.text     = originalPriceStr
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, descriptionLabel, priceLabel, originalPriceLabel)

        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        button.setBackgroundImage(FLImages.getTicket, for: .normal)
        button.setBackgroundImage(FLImages.getTicketDisable, for: .selected)
        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.pinToEdges(of: contentView)
        
        let padding: CGFloat = 9
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 67),
            imageView.widthAnchor.constraint(equalToConstant: 67),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 17),
            
            priceLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 22),
            priceLabel.widthAnchor.constraint(equalTo: priceLabel.widthAnchor ),
            
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: 1),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 7),
            originalPriceLabel.heightAnchor.constraint(equalToConstant: 14),
            originalPriceLabel.widthAnchor.constraint(equalTo: originalPriceLabel.widthAnchor),
            
            button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            button.heightAnchor.constraint(equalTo: button.heightAnchor),
            button.widthAnchor.constraint(equalTo: button.widthAnchor),

        ])
    }
}
