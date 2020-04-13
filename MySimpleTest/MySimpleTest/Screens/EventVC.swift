//
//  EventVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum SectionKind: Int, CaseIterable {
        case shop, event
        var height: CGFloat {
            switch self {
            case .shop:
                return 128
            case .event:
                return 92
            }
        }
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Event>!
    private var eventList: [Event]        = []
    private var dataList: [[Event]]      = [[], []]
    
    var shopID: String!
    var shopTitle: String!
    var shopAddress: String!
    var shopOpenTime: String!
    var shopImageURL: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: FLImages.backButton, style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
        getEventList()
    }
    
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureUI() {
        view.addSubview(collectionView)
        view.backgroundColor = FLColors.white
        
        collectionView.pinToEdges(of: view)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createLayout())
        //collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EventListCell.self, forCellWithReuseIdentifier: EventListCell.reuseID)
        collectionView.register(ShopCell.self, forCellWithReuseIdentifier: ShopCell.reuseID)
        collectionView.register(FLHeaderSV.self, forSupplementaryViewOfKind: ShopVC.sectionHeaderElementKind, withReuseIdentifier: FLHeaderSV.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = FLColors.white
    }
    
    
    private func configureCell(cell: UICollectionViewCell) -> UICollectionViewCell{
        cell.layer.shadowColor     = FLColors.black.cgColor
        cell.layer.shadowOpacity   = 0.06
        cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
        cell.layer.masksToBounds   = false
        cell.layer.shadowRadius    = 3
        return cell
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Event>(collectionView: collectionView) {
            (collectionView, indexPath, event) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            if section == .shop {
                guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ShopCell.reuseID, for: indexPath) as? ShopCell
                    else { fatalError("Cannot create new cell") }
                
                cell.set(title: self.shopTitle, address: self.shopAddress, time: self.shopOpenTime, imageURL: self.shopImageURL)
                
                return self.configureCell(cell: cell)
                
            } else {
                guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: EventListCell.reuseID, for: indexPath) as? EventListCell
                    else { fatalError("Cannot create new cell") }
                
                cell.set(event: event)
                return self.configureCell(cell: cell)
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FLHeaderSV.reuseID,
                for: indexPath) as? FLHeaderSV else { fatalError("Cannot create new advertisment header") }
            
            if indexPath.section == 0 { header.removeView() } else { header.set(title: "优惠活动", hasButton: false, hasDeleteButton: false) }
            
            return header
        }
    }
    
    
    func updateData(on events: [[Event]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Event>()
        for section in [0,1] {
            snapshot.appendSections([section])
            snapshot.appendItems(events[section])
            DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
        }
    }
    
    
    
    func getEventList() {
        FirestoreManager.shared.getEvents(for: shopID, isLimited: false) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let eventList):
                self.eventList = eventList
                var event = eventList[0]
                event.id  = "#"
                self.dataList[0].append(event)
                self.dataList[1] = eventList
                self.updateData(on: self.dataList)
                
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
        }
    }
}



extension EventVC {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = SectionKind(rawValue: sectionIndex) else { return nil }
            let columnHeight = sectionKind.height
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeight = NSCollectionLayoutDimension.absolute(columnHeight)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 7
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 11, trailing: 13)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(5))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: EventVC.sectionHeaderElementKind, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}
