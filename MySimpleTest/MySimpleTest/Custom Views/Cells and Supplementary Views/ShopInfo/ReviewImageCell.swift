//
//  ReviewImageCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ReviewImageCell: UICollectionViewCell {
    
    static let reuseID = "ReviewImageCell"
    let imageView      = FLRegularImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(imageURL: String) {
        imageView.downloadImage(fromURL: imageURL)
    }
    
    
    private func configure() {
        addSubview(imageView)
        imageView.pinToEdges(of: contentView)
    }
}
