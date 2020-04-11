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
    private let titleLabel              = FLTitleLabel(textAlignment: .left, fontSize: 14, textColor: FLColors.black, fontWeight: .regular)
    private let descriptionLabel        = FLTitleLabel(textAlignment: .left, fontSize: 10, textColor: FLColors.gray, fontWeight: .regular)
    private let timeLabel               = FLTitleLabel(textAlignment: .left, fontSize: 10, textColor: FLColors.gray, fontWeight: .regular)
    private let priceLabel              = FLTitleLabel(textAlignment: .left, fontSize: 18, textColor: FLColors.red, fontWeight: .regular)
    private let originalPriceLabel      = FLStrikeThroughLabel(textAlignment: .left, fontSize: 12)
    private let button                  = FLButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        buyButtonTapped()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buyButtonTapped() {
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func addToCart() {
        print("Buy this Event!")
        button.isSelected = true
    }
    
    
    func set(imageURL: String, title: String, description: String,  startDate: Date, endDate: Date, price: Double, originalPrice: Double) {
        imageView.downloadImage(fromURL: imageURL)
        titleLabel.text             = title
        descriptionLabel.text       = description
        timeLabel.text          = "\(startDate.converToYearMonthDayFormat())至\(endDate.converToYearMonthDayFormat())"
        
        let priceStr                = String(format: "%.2f", price)
        let originalPriceStr        = String(format: "%.2f", originalPrice)
        priceLabel.text             = "$\(priceStr)"
        originalPriceLabel.set(text: "$\(originalPriceStr)")
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, descriptionLabel, timeLabel, priceLabel, originalPriceLabel, button)

        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        button.setBackgroundImage(FLImages.addToCart, for: .normal)
        button.setBackgroundImage(FLImages.addToCartClicked, for: .selected)
        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.pinToEdges(of: contentView)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 68),
            imageView.widthAnchor.constraint(equalToConstant: 71),
            
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -11),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 73),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 14),
            
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            timeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -9),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 21),
            priceLabel.widthAnchor.constraint(equalTo: priceLabel.widthAnchor),
            
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: 1),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 6.5),
            originalPriceLabel.heightAnchor.constraint(equalToConstant: 14),
            originalPriceLabel.widthAnchor.constraint(equalToConstant: 45)
            


        ])
    }
}
