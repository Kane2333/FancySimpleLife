//
//  ShopFilterView.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/29.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ShopFilterView: UIView {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    private let optionList: [String] = ["推荐", "餐饮", "生鲜", "娱乐", "旅行", "榜单"]
    
    private var viewWidth: CGFloat = 0
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        configureUI()
        updateData(on: optionList)
        configureDataSource()
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCollectionView() {
        print(self.bounds.width)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UIHelper.shopFilterBarFlowLayout(in: self))
        collectionView.register(ShopFilterCell.self, forCellWithReuseIdentifier: ShopFilterCell.reuseID)
        collectionView.backgroundColor = FLColors.white
        collectionView.delegate = self
    }
    
    
    private func configureUI() {
        addSubview(collectionView)
        collectionView.pinToEdges(of: self)
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView, indexPath, labelText) -> UICollectionViewCell? in
            
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ShopFilterCell.reuseID, for: indexPath) as? ShopFilterCell
                else { fatalError("Cannot create new cell") }
            cell.set(text: labelText)
            return cell
        }
    }
    
    
    func updateData(on options: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(options)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: false)}
    }
}


extension ShopFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = optionList[indexPath.item]
        
    }
}
