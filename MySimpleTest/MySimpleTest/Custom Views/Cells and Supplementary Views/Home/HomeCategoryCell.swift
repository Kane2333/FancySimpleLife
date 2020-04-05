//
//  HomeCategoryCell.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class HomeCategoryCell: UICollectionViewCell {
    
    static let reuseID = "HomeCategoryCell"
    let imageView      = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(image: UIImage) {
        imageView.image = image
    }
    
    
    private func configure() {
        addSubview(imageView)
        imageView.layer.cornerRadius                        = 6
        imageView.clipsToBounds                             = true
        imageView.contentMode                               = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.pinToEdges(of: contentView)
    }
}
