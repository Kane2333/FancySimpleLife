//
//  SearchVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        customCancelButton()
        createDismissKeyboardTapGesture()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        searchController.hidesNavigationBarDuringPresentation           = false
        searchController.searchBar.showsCancelButton                    = false
        searchController.isActive = true
        
        
    }
    
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor             = FLColors.white
        navigationController?.navigationBar.isTranslucent               = false
        navigationController?.navigationBar.shadowImage                 = UIImage()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater                           = self
        searchController.searchBar.delegate                             = self
        searchController.delegate                                       = self
        searchController.searchBar.placeholder                          = "搜索商家、活动"
        searchController.searchBar.searchTextField.layer.cornerRadius   = 3
        searchController.searchBar.searchTextField.layer.masksToBounds  = true
        searchController.obscuresBackgroundDuringPresentation           = false
        searchController.searchBar.tintColor                            = FLColors.black
        searchController.automaticallyShowsCancelButton                 = true
        navigationItem.titleView                                        = searchController.searchBar
        navigationItem.hidesBackButton                                  = true
    }
    
    
    func customCancelButton() {
        let cancelButton = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(popView))
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: FLColors.black], for: .normal)
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func dismissKeyboard() {
        dismiss(animated: true)
    }
    
    @objc func popView() {
        searchController.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension SearchVC: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { searchController.searchBar.becomeFirstResponder()}
    }
}

extension SearchVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}





