//
//  ShopCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    static let reuseID = "ShopCell"
    
    private let containerView   = UIView()
    private let imageView       = FLRegularImageView(frame: .zero)
    private let titleLabel      = FLTitleLabel(textAlignment: .left, fontSize: 16, textColor: FLColors.black, fontWeight: .regular)
    private let addressLabel    = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let timeLabel       = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    private let entryButton     = FLButton()
    private let likeButton      = FLButton()
    private let shareButton     = FLButton()
    
    private var isOn            = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        entryButtonTapped()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(title: String, address: String, time: String, imageURL: String) {
        titleLabel.text     = title
        addressLabel.text   = address
        timeLabel.text      = "营业时间： \(time)"
        imageView.downloadImage(fromURL: imageURL)
    }
    
    func activateLikeButton(bool: Bool) {
        isOn = bool
        likeButton.isSelected = isOn
    }
    
    
    @objc func likeButtonPressed() {
        activateLikeButton(bool: !isOn)
    }
    
    
    func entryButtonTapped() {
        entryButton.addTarget(self, action: #selector(pushProductVC), for: .touchUpInside)
    }
    
    
    @objc func pushProductVC() {
        print("push to product VC")
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, addressLabel, timeLabel, likeButton, shareButton, entryButton)
        
        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        likeButton.backgroundColor  = FLColors.white
        likeButton.setImage(FLImages.heart, for: .normal)
        likeButton.setImage(FLImages.redHeart, for: .selected)
        likeButton.addTarget(self, action: #selector(ShopCell.likeButtonPressed), for: .touchUpInside)
        
        shareButton.setImage(FLImages.share, for: .normal)
        shareButton.backgroundColor = FLColors.white
        
        entryButton.setBackgroundImage(FLImages.entryShop, for: .normal)
        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.pinToEdges(of: contentView)
        
        let padding: CGFloat = 13
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 105),
            imageView.widthAnchor.constraint(equalToConstant: 108),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 21),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            addressLabel.heightAnchor.constraint(equalToConstant: 17),
            
            timeLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 17),
            timeLabel.widthAnchor.constraint(equalToConstant: 130),
            
            likeButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            likeButton.heightAnchor.constraint(equalToConstant: 19),
            likeButton.widthAnchor.constraint(equalToConstant: 21),
            
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),
            shareButton.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 19),
            shareButton.widthAnchor.constraint(equalToConstant: 19),
            
            entryButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            entryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            entryButton.heightAnchor.constraint(equalToConstant: 26),
            entryButton.widthAnchor.constraint(equalToConstant: 101)

        ])
    }
}
