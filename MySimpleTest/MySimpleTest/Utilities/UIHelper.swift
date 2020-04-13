 //
 //  UIHelper.swift
 //  FancyLifeDemo
 //
 //  Created by Laverne  on 2020/3/26.
 //  Copyright © 2020 FancyLife. All rights reserved.
 //
 
 import UIKit
 
 struct UIHelper {
    
    static func createAdImageFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize                 = CGSize(width: view.bounds.width, height: 139)
        flowLayout.minimumInteritemSpacing  = 0
        flowLayout.scrollDirection          = .horizontal
        
        return flowLayout
    }
    
    
    static func shopFilterBarFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.itemSize                 = CGSize(width: 58, height: 60)
        //flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        flowLayout.minimumInteritemSpacing  = 0
        
        return flowLayout
    }
    
    
    static func createHorizontalFlowLayoutOneSection(in view: UIView) -> UICollectionViewLayout {
        
        let padding: CGFloat            = 13
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.itemSize             = CGSize(width: 139, height: 139)
        flowLayout.scrollDirection      = .horizontal
        return flowLayout
    }
    
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewCompositionalLayout {
        let itemSize                        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(225))
        let item                            = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize                       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(225))
        let group                           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing              = .fixed(11)
                
        let section                         = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing           = 14
        section.contentInsets               = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
                
        let headerFooterSize                = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader                   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: HomeVC.sectionHeaderElementKind, alignment: .top)
        section.boundarySupplementaryItems  = [sectionHeader]
        let layout                          = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    static func createListFlowLayout(in view: UIView, hasHeader: Bool) -> UICollectionViewCompositionalLayout {
        let itemSize                        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item                            = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize                       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(85))
        let group                           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section                         = NSCollectionLayoutSection(group: group)
        section.contentInsets               = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        section.interGroupSpacing           = 7
        if hasHeader {
            let sectionHeader                   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(139)), elementKind: ShopVC.sectionHeaderElementKind, alignment: .top)
            
            sectionHeader.pinToVisibleBounds    = true
            sectionHeader.zIndex                = 2
            section.boundarySupplementaryItems  = [sectionHeader]
            
        }
        
        let layout                          = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    static func createDynamicGridLayout(in view: UIView) -> UICollectionViewLayout {
        let itemSize                = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .absolute(25))
        let item                    = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize               = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let group                   = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing      = .fixed(11)
        
        let section                 = NSCollectionLayoutSection(group: group)
        section.contentInsets       = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 15, trailing: 13)
        section.interGroupSpacing   = 11
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SearchVC.sectionHeaderElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout                  = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
 }
 
 
