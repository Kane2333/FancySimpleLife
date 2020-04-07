//
//  ProductVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Product>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: FLImages.backButton, style: .done, target: self, action: #selector(backToHome))
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    @objc func backToHome() {
        navigationController?.popViewController(animated: true)
    }

    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createListFlowLayout(in: view))
        //collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.reuseID)
        collectionView.register(ShopHeaderSV.self, forSupplementaryViewOfKind: ShopVC.sectionHeaderElementKind, withReuseIdentifier: ShopHeaderSV.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = FLColors.white
    }


}
