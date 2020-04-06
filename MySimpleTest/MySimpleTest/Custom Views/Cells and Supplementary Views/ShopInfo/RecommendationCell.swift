//
//  RecommendationCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class RecommendationCell: UICollectionViewCell {
    static let reuseID              = "RecommendationCell"
    
    private let containerView   = UIView()
    private let imageView       = FLRegularImageView(frame: .zero)
    private let titleLabel      = FLTitleLabel(textAlignment: .left, fontSize: 14, textColor: FLColors.black, fontWeight: .regular)
    private let starSymbol      = UIImageView()
    private let scoreLabel      = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.black, fontWeight: .regular)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(title: String, imageURL: String, score: Double) {
        titleLabel.text = title
        imageView.downloadImage(fromURL: imageURL)
        let scoreStr    = String(format: "%.1f", score)
        scoreLabel.text = scoreStr
    }
    
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel, starSymbol, scoreLabel)
        
        titleLabel.numberOfLines = 2

        starSymbol.image                                        = FLImages.star
        starSymbol.translatesAutoresizingMaskIntoConstraints    = false
        
        imageView.layer.cornerRadius    = 3
        imageView.layer.masksToBounds   = true
        
        containerView.backgroundColor       = FLColors.white
        containerView.layer.cornerRadius    = 6
        containerView.layer.masksToBounds   = true
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 85),
            imageView.widthAnchor.constraint(equalToConstant: 84),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3.5),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 84),
            
            starSymbol.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            starSymbol.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            starSymbol.heightAnchor.constraint(equalToConstant: 11),
            starSymbol.widthAnchor.constraint(equalToConstant: 11),
            
            scoreLabel.centerYAnchor.constraint(equalTo: starSymbol.centerYAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: starSymbol.trailingAnchor, constant: 7),
            scoreLabel.heightAnchor.constraint(equalToConstant: 17),
            scoreLabel.widthAnchor.constraint(equalToConstant: 22)
        ])
        containerView.pinToEdges(of: self.contentView)
    }
}
