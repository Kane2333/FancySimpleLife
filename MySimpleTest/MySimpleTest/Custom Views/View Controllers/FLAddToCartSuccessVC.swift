//
//  FLAddToCartSuccessVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/14.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLAddToCartSuccessVC: UIViewController {
    
    let imageView = FLRegularImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    
    }
    
    
    private func configureUI() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(imageView)
        imageView.image = FLImages.addToCartSuccess
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }

}
