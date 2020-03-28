//
//  HomeLocationVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class HomeLocationVC: UIViewController {

    private let locationSymbol  = UIImageView()
    private let label           = FLTitleLabel(textAlignment: .left, fontSize: 14, textColor: FLColors.black, fontWeight: .regular)
    private let arrowSymbol     = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
     
    }
    
    
    private func configure() {
        locationSymbol.image        = FLImages.location
        arrowSymbol.image           = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
        locationSymbol.tintColor    = FLColors.red
        arrowSymbol.tintColor       = FLColors.red
        
        view.addSubViews(locationSymbol, label, arrowSymbol)
        
        locationSymbol.translatesAutoresizingMaskIntoConstraints    = false
        arrowSymbol.translatesAutoresizingMaskIntoConstraints       = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.heightAnchor.constraint(equalToConstant: 16),
            label.leadingAnchor.constraint(equalTo: locationSymbol.trailingAnchor, constant: 7),
            label.widthAnchor.constraint(equalToConstant: 190),
            
            locationSymbol.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationSymbol.widthAnchor.constraint(equalTo: locationSymbol.widthAnchor),
            locationSymbol.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            locationSymbol.heightAnchor.constraint(equalTo: locationSymbol.heightAnchor),
            
            arrowSymbol.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            arrowSymbol.widthAnchor.constraint(equalTo: arrowSymbol.widthAnchor),
            arrowSymbol.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 1),
            arrowSymbol.heightAnchor.constraint(equalTo: arrowSymbol.heightAnchor)
        ])
    }
    
    
    func setLocation(location: String) {
        label.text = location
    }
}
