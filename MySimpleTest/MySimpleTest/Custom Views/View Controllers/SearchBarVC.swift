//
//  SearchBarVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class SearchBarVC: FLDataLoadingVC {
    
    private let searchBar           = UIButton()
    private let mapButton           = FLButton(title: "附近商家", textColor: FLColors.red, fontSize: 12)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchBarTapped()
        mapButtonTapped()
    }
    
    
    private func configureUI() {
        view.addSubviews(searchBar, mapButton)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.setBackgroundImage(FLImages.searchBar, for: .normal)
        
        NSLayoutConstraint.activate([
            
            mapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: 50),
            mapButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            mapButton.heightAnchor.constraint(equalToConstant: 20),
            
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.widthAnchor.constraint(equalTo: searchBar.widthAnchor)
            
        ])
    }
    
    
    private func searchBarTapped() {
        searchBar.addTarget(self, action: #selector(pushSearchVC), for: .touchUpInside)
    }
    
    
    @objc func pushSearchVC() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    private func mapButtonTapped() {
        mapButton.addTarget(self, action: #selector(pushMapVC), for: .touchUpInside)
    }
    
    
    @objc func pushMapVC() {
        navigationController?.pushViewController(MapVC(), animated: true)
    }
}

