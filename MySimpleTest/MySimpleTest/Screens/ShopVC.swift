//
//  ShopVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit
import CoreLocation


class ShopVC: FLDataLoadingVC {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private var category: String?   = nil

    private let searchBar       = UIButton()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Shop>!
    private var shopList: [Shop]        = []
    private var filterShopList: [Shop]  = []
    private var dataList: [[Shop]]      = [[], []]
    private var isLoading: Bool         = false
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    init(category:String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        getShopItems()
        configureDataSource()
        configureSearchBar()
        searchBarTapped()
        customRightButton()
        setUpLocationManager()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar()
        if category != nil {
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    
    private func configureSearchBar() {
        searchBar.setBackgroundImage(FLImages.searchBar, for: .normal)
        navigationItem.titleView = searchBar
    }
    
    
    private func searchBarTapped() {
        searchBar.addTarget(self, action: #selector(pushSearchVC), for: .touchUpInside)
    }
    
    
    @objc func pushSearchVC() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor             = FLColors.white
        navigationController?.navigationBar.isTranslucent               = false
        navigationController?.navigationBar.shadowImage                 = UIImage()
        navigationItem.backBarButtonItem?.title = ""
        if category != nil {
            let backButton = UIBarButtonItem(image: FLImages.backButton, style: .done, target: self, action: #selector(backToHome))
            navigationItem.leftBarButtonItem = backButton
            searchBar.setBackgroundImage(FLImages.searchBarCut, for: .normal)
        }
    }
    
    
    @objc func backToHome() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func customRightButton() {
        let rightButton = UIBarButtonItem(title: "附近商家", style: .done, target: self, action: #selector(pushMapVC))
        rightButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: FLColors.red], for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    
    @objc func pushMapVC() {
        navigationController?.pushViewController(MapVC(), animated: true)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createListFlowLayout(in: view, hasHeader: true))
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShopListCell.self, forCellWithReuseIdentifier: ShopListCell.reuseID)
        collectionView.register(ShopHeaderSV.self, forSupplementaryViewOfKind: ShopVC.sectionHeaderElementKind, withReuseIdentifier: ShopHeaderSV.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = FLColors.white
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Shop>(collectionView: collectionView) {
            (collectionView, indexPath, shop) -> UICollectionViewCell? in
            
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ShopListCell.reuseID, for: indexPath) as? ShopListCell
                else { fatalError("Cannot create new cell") }
            let shopLocation = CLLocation(latitude: shop.location[0], longitude: shop.location[1])
            let distance = self.userLocation?.distance(from: shopLocation) ?? 0
            //cell.prepareForReuse()
            cell.set(shop: shop, distance: distance)
            cell.layer.shadowColor     = FLColors.black.cgColor
            cell.layer.shadowOpacity   = 0.06
            cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
            cell.layer.masksToBounds   = false
            cell.layer.shadowRadius    = 3
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ShopHeaderSV.reuseID,
                for: indexPath) as? ShopHeaderSV else { fatalError("Cannot create new advertisment header") }
            
            if indexPath.section == 0 {
                header.setImage()

            } else {
                header.setFilterBar()
            }
            
            if self.category != nil {
                header.changeOption(category: self.category!)
            }
            header.delegate = self
            header.backgroundColor = FLColors.white
            return header
        }
    }
    
    
    func updateData(on shops: [[Shop]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Shop>()
        for section in [0,1] {
            snapshot.appendSections([section])
            snapshot.appendItems(shops[section])
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.dataSource.apply(snapshot, animatingDifferences: false)
            
        }
    }
    
    
    func getShopItems() {
        showLoadingView()
        isLoading = true
        FirestoreManager.shared.getShopList() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let shopList):
                self.shopList = shopList
                if self.category == nil {
                    self.dataList[1] = shopList

                } else {
                    self.filterShop(category: self.category!)
                }
                 self.updateData(on: self.dataList)
               
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
                        self.dismissLoadingView()
            self.isLoading = false
        }
    }
    
    
    private func configureUI() {
        view.addSubview(collectionView)
        view.backgroundColor = FLColors.white
        extendedLayoutIncludesOpaqueBars = true
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func filterShop(category: String) {
        switch category {
        case "推荐":
            filterShopList.removeAll()
            filterShopList = shopList
        case "餐饮", "生鲜", "娱乐", "旅行":
            filterShopList.removeAll()
            for shop in shopList {
                if shop.category == category {
                    self.filterShopList.append(shop)
                }
            }
        case "榜单":
            filterShopList.removeAll()
            filterShopList = shopList.sorted(by: { (shop1, shop2) -> Bool in
                return shop1.score > shop2.score
            })
            
        default:
            break
        }
        dataList[1] = filterShopList
    }
    

    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}


extension ShopVC: ShopHeaderSVDelegate {
    func didRequestToUpdateShops(for category: String) {
        
        filterShop(category: category)
        updateData(on: self.dataList)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
    }
}


extension ShopVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!
    }
}


extension ShopVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = dataList[1]
        let shop        = activeArray[indexPath.item]
        let destVC      = ShopInfoVC()
        destVC.shop     = shop
        navigationController?.pushViewController(destVC, animated: true)
    }
}
