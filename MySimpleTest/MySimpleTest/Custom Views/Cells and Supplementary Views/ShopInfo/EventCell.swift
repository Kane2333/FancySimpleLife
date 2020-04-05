//
//  EventCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    static let reuseID = "EventCell"
    
    private let containerView           = UIView()
    private let imageView               = FLRegularImageView(frame: .zero)
    private let titleLabel              = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let descriptionLabel        = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let timeLabel               = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let priceLabel              = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.red, fontWeight: .regular)
    private let originalPriceLabel      = FLStrikeThroughLabel(textAlignment: .center, fontSize: 12)
    private let likeButton              = FLButton()
    private let ticketButton            = FLButton()
    
    private var isOn                    = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(title: String, description: String, startDate: Date, endDate: Date, price: Double, originalPrice: Double, imageURL: String) {
        let priceStr = String(format: "%.2f", price)
        let originalPriceStr = String(format: "%.2f", originalPrice)
        
        titleLabel.text         = title
        descriptionLabel.text   = description
        timeLabel.text          = "活动时间： \(startDate.converToYearMonthDayFormat())至\(endDate.converToYearMonthDayFormat())"
        priceLabel.text         = "$\(priceStr)"
        originalPriceLabel.set(text: "$\(originalPriceStr)")
        imageView.downloadImage(fromURL: imageURL)
    }
    
    
    func activateLikeButton(bool: Bool) {
        isOn = bool
        likeButton.isSelected = isOn
    }
    
    
    @objc func likeButtonPressed() {
        activateLikeButton(bool: !isOn)
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, descriptionLabel, timeLabel, priceLabel, originalPriceLabel, likeButton, ticketButton)
        
        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        likeButton.backgroundColor  = FLColors.white
        likeButton.setImage(FLImages.heart, for: .normal)
        likeButton.setImage(FLImages.redHeart, for: .selected)
        likeButton.addTarget(self, action: #selector(ShopCell.likeButtonPressed), for: .touchUpInside)
        ticketButton.setBackgroundImage(FLImages.ticket, for: .normal)

        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.pinToEdges(of: contentView)
        
        let padding: CGFloat = 9
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 105),
            imageView.widthAnchor.constraint(equalToConstant: 109),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -53),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 17),
            
            timeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 17),
            timeLabel.widthAnchor.constraint(equalToConstant: 213),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            priceLabel.widthAnchor.constraint(equalToConstant: 52),
            priceLabel.heightAnchor.constraint(equalToConstant: 19),
            
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 7),
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            originalPriceLabel.widthAnchor.constraint(equalToConstant: 40),
            originalPriceLabel.heightAnchor.constraint(equalToConstant: 14),
            
            likeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            likeButton.heightAnchor.constraint(equalToConstant: 19),
            likeButton.widthAnchor.constraint(equalToConstant: 21),
            
            ticketButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            ticketButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            ticketButton.heightAnchor.constraint(equalToConstant: 26),
            ticketButton.widthAnchor.constraint(equalToConstant: 101)
        ])
    }
}
