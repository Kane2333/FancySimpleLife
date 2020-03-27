//
//  HomeVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    enum Section { case main }
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    private let containerView   = UIView()
    private let locationView    = UIView()
    private let searchBar       = UIView()
    private let adView          = UIView()
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    lazy var scrollView: FLScrollView = {
        let scrollView = FLScrollView(view: view, containerView: containerView, contentViewSize: contentViewSize, bounces: true)
        return scrollView
    }()
    
    var categoryCollectionView: UICollectionView!
    var tuanGoCollectionView: UICollectionView!
    var categrotyDataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    var tuanGoDataSource: UICollectionViewDiffableDataSource<Section, TuanGo>!
    var categoryImages: [UIImage] = []
    var tuanGoList: [TuanGo]      = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = FLColors.white
        let homeLocationVC = HomeLocationVC()
        homeLocationVC.setLocation(location: "639 Lonsdale St, Melbourne VIC 3000")
        add(childVC: homeLocationVC, to: locationView)
        add(childVC: SearchBarVC(), to: searchBar)
        add(childVC: FLAdvertVC(), to: adView)
        configureCategoryCollectionView()
        configureTuanGoCollectionView()
        configureUI()
        getCategoryItems()
        configureCategoryDataSource()
        getTuanGoItems()
        configureTuanGoDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func configureUI() {
        view.addSubview(scrollView)
        containerView.addSubViews(locationView, searchBar, adView, categoryCollectionView, tuanGoCollectionView)
        
        locationView.translatesAutoresizingMaskIntoConstraints           = false
        searchBar.translatesAutoresizingMaskIntoConstraints              = false
        adView.translatesAutoresizingMaskIntoConstraints                 = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tuanGoCollectionView.translatesAutoresizingMaskIntoConstraints   = false
        
        let padding: CGFloat = 13
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 7),
            locationView.heightAnchor.constraint(equalToConstant: 18),
            locationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            locationView.widthAnchor.constraint(equalTo: locationView.widthAnchor),
            
            searchBar.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 9),
            searchBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            searchBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            
            adView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            adView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            adView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            adView.heightAnchor.constraint(equalToConstant: 139),
            
            categoryCollectionView.topAnchor.constraint(equalTo: adView.bottomAnchor, constant: 15),
            categoryCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 139),
            
            tuanGoCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10),
            tuanGoCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            tuanGoCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            tuanGoCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    
    func configureCategoryCollectionView() {
        categoryCollectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: UIHelper.createHorizontalFlowLayoutOneSection(in: containerView))
        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseID)
        categoryCollectionView.backgroundColor = FLColors.white
        categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    
    
    func configureCategoryDataSource() {
        categrotyDataSource = UICollectionViewDiffableDataSource<Int, UIImage>(collectionView: categoryCollectionView) {
            (collectionView, indexPath, image) -> UICollectionViewCell? in
            
            guard let cell = self.categoryCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseID, for: indexPath) as? HomeCategoryCell
                else { fatalError("Cannot create new cell") }
            cell.set(image: image)
            return cell
        }
    }
    
    
    func updateCategoryData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(categoryImages)
        DispatchQueue.main.async {self.categrotyDataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    
    func getCategoryItems() {
        categoryImages = [UIImage(named: "item1")!,
                          UIImage(named: "item2")!,
                          UIImage(named: "item3")!,
                          UIImage(named: "item4")!]
        updateCategoryData()
    }
    
    
    func configureTuanGoCollectionView() {
        tuanGoCollectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: containerView))
        tuanGoCollectionView.register(HomeTuanGoCell.self, forCellWithReuseIdentifier: HomeTuanGoCell.reuseID)
        tuanGoCollectionView.register(HomeTuanGoSV.self, forSupplementaryViewOfKind: HomeVC.sectionHeaderElementKind, withReuseIdentifier: HomeTuanGoSV.reuseID)
        tuanGoCollectionView.backgroundColor = FLColors.white
        tuanGoCollectionView.isScrollEnabled = false
        //categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    
    
    func configureTuanGoDataSource() {
        tuanGoDataSource = UICollectionViewDiffableDataSource<Section, TuanGo>(collectionView: tuanGoCollectionView) {
            (collectionView, indexPath, tuanGo) -> UICollectionViewCell? in
            
            guard let cell = self.tuanGoCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTuanGoCell.reuseID, for: indexPath) as? HomeTuanGoCell
                else { fatalError("Cannot create new cell") }
            cell.set(tuanGoItem: tuanGo)
            cell.layer.shadowColor     = FLColors.black.cgColor
            cell.layer.shadowOpacity   = 0.07
            cell.layer.shadowOffset    = CGSize(width: 1, height: 3)
            cell.layer.shadowRadius    = 3
            return cell
        }
        
        tuanGoDataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in

            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeTuanGoSV.reuseID,
                for: indexPath) as? HomeTuanGoSV else { fatalError("Cannot create new supplementary") }

            supplementaryView.backgroundColor       = FLColors.white
            return supplementaryView
        }
    }
    
    
    func updateTuanGoData(on tuanGoItems: [TuanGo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TuanGo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tuanGoItems)
        DispatchQueue.main.async {self.tuanGoDataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    
    func getTuanGoItems() {
        let tuanGo1 = TuanGo(title: "麻辣土豆香锅", secondaryTitle: "中式传统美食", amount: Int(99), price: Double(23.46), originalPrice: Double(30.50), imageName: "item4")
        let tuanGo2 = TuanGo(title: "意大利面", secondaryTitle: "经典西餐", amount: Int(50), price: Double(19.99), originalPrice: Double(25.50), imageName: "item3")
        let tuanGo3 = TuanGo(title: "中式双人套餐", secondaryTitle: "网红打卡中餐厅", amount: Int(20), price: Double(59.99), originalPrice: Double(90.50), imageName: "item2")
        let tuanGo4 = TuanGo(title: "法式蜗牛套餐", secondaryTitle: "经典法国风味", amount: Int(18), price: Double(64.89), originalPrice: Double(98.50), imageName: "item1")
        let tuanGo5 = TuanGo(title: "中式双人套餐2", secondaryTitle: "网红打卡中餐厅", amount: Int(20), price: Double(59.99), originalPrice: Double(90.50), imageName: "item2")
        let tuanGo6 = TuanGo(title: "法式蜗牛套餐2", secondaryTitle: "经典法国风味", amount: Int(18), price: Double(64.89), originalPrice: Double(98.50), imageName: "item1")
        
        tuanGoList = [tuanGo1, tuanGo2, tuanGo3, tuanGo4, tuanGo5, tuanGo6]
        
        updateTuanGoData(on: tuanGoList)
    }
}
