//
//  SearchBarVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class SearchBarVC: UIViewController {
    
    private let transparentButton   = UIButton()
    private let searchBar           = UISearchBar()
    private let mapButton           = FLTextButton(title: "附近商家", textColor: FLColors.red, fontSize: 12)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTapGesture()
    }
    
    
    @objc func pushSearchVC() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    func addTapGesture() {
        transparentButton.addTarget(self, action: #selector(pushSearchVC), for: .touchUpInside)
    }
    
    
    private func configureUI() {
        view.addSubViews(transparentButton, searchBar, mapButton)
        
        searchBar.translatesAutoresizingMaskIntoConstraints            = false
        transparentButton.translatesAutoresizingMaskIntoConstraints    = false
        
        searchBar.backgroundImage                       = UIImage() // delete the line between the view
        searchBar.placeholder                           = "搜索商家、活动"
        searchBar.searchTextField.layer.cornerRadius    = 3
        searchBar.searchTextField.layer.masksToBounds   = true
        searchBar.searchTextField.backgroundColor       = FLColors.lightGray
        searchBar.showsCancelButton                     = false
        searchBar.setPositionAdjustment(UIOffset(horizontal: 8, vertical: 1), for: .search)
        searchBar.searchTextPositionAdjustment.vertical = 1
        // change search bar textfield font size and color
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]// ,NSAttributedString.Key.foregroundColor: UIColor.gray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
        

        transparentButton.backgroundColor  = UIColor.white.withAlphaComponent(0.0)
        view.bringSubviewToFront(transparentButton)
        let width = view.bounds.width
        
        NSLayoutConstraint.activate([
            
            mapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: 50),
            mapButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            mapButton.heightAnchor.constraint(equalToConstant: 20),
            
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -8),
            searchBar.widthAnchor.constraint(equalToConstant: width * 305 / 375),
            
            transparentButton.topAnchor.constraint(equalTo: searchBar.topAnchor),
            transparentButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            transparentButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            transparentButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
    

}

