//
//  ShopHeaderSV.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/28.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopHeaderSV: UICollectionReusableView {
    
    static let reuseID      = "ShopHeaderSV"
    
    private let containerViewOne    = UIView(frame: .zero)
    private let containerViewTwo    = UIView(frame: .zero)
    private let adView              = FLRegularImageView(frame: .zero)
    private let filterBar           = ShopFilterView()
    
    
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
        
        containerViewOne.addSubview(adView)
        containerViewTwo.removeFromSuperview()
        filterBar.removeFromSuperview()
        
        NSLayoutConstraint.activate([
            adView.topAnchor.constraint(equalTo: containerViewOne.topAnchor),
            adView.leadingAnchor.constraint(equalTo: containerViewOne.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: containerViewOne.trailingAnchor),
            adView.bottomAnchor.constraint(equalTo: containerViewOne.bottomAnchor),
            containerViewOne.heightAnchor.constraint(equalToConstant: 139)
        ])
        
        configureUI(containerView: containerViewOne)
    }
    

    func setFilterBar() {
        containerViewTwo.addSubview(filterBar)
        adView.removeFromSuperview()
        containerViewOne.removeFromSuperview()

        filterBar.translatesAutoresizingMaskIntoConstraints = false
        
        filterBar.pinToEdges(of: containerViewTwo)
        
        NSLayoutConstraint.activate([
            filterBar.topAnchor.constraint(equalTo: containerViewTwo.topAnchor),
            filterBar.leadingAnchor.constraint(equalTo: containerViewTwo.leadingAnchor),
            filterBar.trailingAnchor.constraint(equalTo: containerViewTwo.trailingAnchor),
            filterBar.bottomAnchor.constraint(equalTo: containerViewTwo.bottomAnchor),
            containerViewTwo.heightAnchor.constraint(equalToConstant: 60)
        ])
        configureUI(containerView: containerViewTwo)
    }

    
    private func configureUI(containerView: UIView) {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 3
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}