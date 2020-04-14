//
//  ShopFilterView.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/29.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

protocol ShopFilterViewDelegate: class {
    func sendCategory(category: String)
}

class ShopFilterView: UIView{
    
    weak var delegate: ShopFilterViewDelegate!
    
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
        let indexPath = IndexPath(item: 0, section: 0)
        DispatchQueue.main.async {
           self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            
        }
        collectionView.allowsSelection = true
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCollectionView() {
        print(self.bounds.width)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UIHelper.shopFilterBarFlowLayout(in: self))
        self.collectionView.delegate = self
        collectionView.register(ShopFilterCell.self, forCellWithReuseIdentifier: ShopFilterCell.reuseID)
        collectionView.backgroundColor = FLColors.white
        
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
    
    
    func changeOption(category: String) {
        var item: Int? = nil
        switch category {
        case "餐饮":
            item = 1
        case "生鲜":
            item = 2
        case "娱乐":
            item = 3
        case "旅行":
            item = 4
        default:
            break
        }
        guard item != nil else { return }
        let indextPath = IndexPath(item: item!, section: 0)
        DispatchQueue.main.async {
            self.collectionView.selectItem(at: indextPath, animated: true, scrollPosition: .left)
        }
        
    }
    
}

extension ShopFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.collectionView.cellForItem(at: indexPath) != nil else {
              return
        }
        let category = optionList[indexPath.item]
        delegate.sendCategory(category: category)
    }
}


