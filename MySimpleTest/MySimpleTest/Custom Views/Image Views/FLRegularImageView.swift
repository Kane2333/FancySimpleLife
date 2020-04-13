//
//  FLRegularImageView.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/28.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLRegularImageView: UIImageView {
    
    let cache = FirestoreManager.shared.cache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        image                                       = FLImages.defaultBackground
        contentMode                                 = .scaleAspectFill
        clipsToBounds                               = true
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    
    func downloadImage(fromURL url: String) {
        FirestoreManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
