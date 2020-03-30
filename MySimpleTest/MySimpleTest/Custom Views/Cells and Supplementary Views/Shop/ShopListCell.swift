//
//  ShopListCell.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/29.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopListCell: UICollectionViewCell {
    
    static let reuseID = "ShopListCell"
    
    private let containerView   = UIView()
    private let imageView       = FLRegularImageView(frame: .zero)
    private let titleLabel      = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let secondaryTitleLabel  = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let distanceLabel   = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let starSymbol      = UIImageView()
    private let scoreLabel      = FLTitleLabel(textAlignment: .left, fontSize: 10, textColor: FLColors.black, fontWeight: .regular)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(imageURL: String, title: String, secondaryTitle: String, distance: Double, score: Double) {
        imageView.downloadImage(fromURL: imageURL)
        titleLabel.text = title
        secondaryTitleLabel.text = secondaryTitle
        
        if distance > 1000 {
            let dist = Int(distance / 1000)
            distanceLabel.text = "距离\(dist)千米"
        } else {
            let dist = Int(distance)
            distanceLabel.text = "距离\(dist)米"
        }
        
        let scoreStr = String(format: "%.1f", score)
        scoreLabel.text = scoreStr
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, secondaryTitleLabel, distanceLabel, starSymbol, scoreLabel)

        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        starSymbol.image                = FLImages.star
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        starSymbol.translatesAutoresizingMaskIntoConstraints    = false
        
        let padding: CGFloat = 9
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 67),
            imageView.widthAnchor.constraint(equalToConstant: 67),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 17),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            
            secondaryTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            secondaryTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            secondaryTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            secondaryTitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            distanceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            distanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: 17),
            distanceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            scoreLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            scoreLabel.heightAnchor.constraint(equalToConstant: 14),
            scoreLabel.widthAnchor.constraint(equalToConstant: 15),
            
            starSymbol.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            starSymbol.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -7),
            starSymbol.heightAnchor.constraint(equalTo: starSymbol.heightAnchor),
            starSymbol.widthAnchor.constraint(equalTo: starSymbol.widthAnchor),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
