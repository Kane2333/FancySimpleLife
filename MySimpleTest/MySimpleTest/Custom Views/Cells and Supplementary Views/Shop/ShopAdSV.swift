//
//  ShopAdSV.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/14.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopAdSV: UICollectionReusableView {
    static let reuseID      = "ShopAdSV"
    
    private let containerView    = UIView()
    private let adView           = FLRegularImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImage() {
        FirestoreManager.shared.getAdList(for: "shoppage") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case . success(let imageList):
                self.adView.downloadImage(fromURL: imageList[0].imageURL)
            case .failure(let error):
                // add error image
                print("image \(error.rawValue)")
            }
        }
        containerView.addSubview(adView)
        
        adView.pinToEdges(of: containerView)
    }
    
    
    private func configureUI(containerView: UIView) {
        addSubview(containerView)
        containerView.pinToEdges(of: self)
    }
}
