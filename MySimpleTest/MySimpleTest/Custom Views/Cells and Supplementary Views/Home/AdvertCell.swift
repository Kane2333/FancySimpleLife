//
//  AdvertCell.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class AdvertCell: UICollectionViewCell {
    
    static let reuseID  = "AdvertCell"
    let imageView       = FLRegularImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    func set(imageURL: String) {
        imageView.downloadImage(fromURL: imageURL)
    }
    
    
    func setImage() {
        FirestoreManager.shared.getAdList(for: "shoppage") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case . success(let imageList):
                self.imageView.downloadImage(fromURL: imageList[0].imageURL)
            case .failure(let error):
                print("image \(error.rawValue)")
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(imageView)
        
        imageView.backgroundColor = FLColors.white
        
        imageView.pinToEdges(of: contentView)
        
    }
}
