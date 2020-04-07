//
//  ShopInfoVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/3/31.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit



class ShopInfoVC: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum SectionKind: Int, CaseIterable {
        case shop, event, product, review, recommendation
        var height: CGFloat {
            switch self {
            case .shop:
                return 128
            case .event:
                return 125
            case .product:
                return 129
            case .review:
                return 125
            case .recommendation:
                return 162
            }
        }
        var columns: Int {
            switch self {
            case .shop, .event, .review:
                return 1
            case .product, .recommendation:
                return 3
            }
        }
    }
    
    var shopID: String!
    var shopTitle: String!
    var shopAddress: String!
    var shopOpenTime: String!
    var shopImageURL: String!
    var shopCategory: String!
    var shopKind: String!
    var totalReviews: Int = 0
    var recommendationShops: [Shop] = []
    var dataList: [[ShopInfo]] = []
    
    let sectionTitles:[String] = ["", "商家活动", "推荐产品", "评论", "相似商家推荐"]
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionKind, ShopInfo>!  = nil
    private var collectionView: UICollectionView!                                       = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        configureDataSource()
        getShopInfoItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: FLImages.backButton, style: .done, target: self, action: #selector(backToHome))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backToHome() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)
    }
    
    
    func getShopInfoItems() {
        var firstEvent: Event!
        var productList: [Product] = []
        var firstReview: Review!
        var shopList: [Shop] = []
        FirestoreManager.shared.getFirstEvent(for: shopID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let event):
                firstEvent = event
                FirestoreManager.shared.getThreeProducts(for: self.shopID) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let products):
                        productList = products
                        var productImages: [String] = []
                        for product in productList {
                            productImages.append(product.imageURL)
                        }
                        FirestoreManager.shared.getFirstReview(for: self.shopID) { [weak self] result in
                            guard let self = self else { return }
                            
                            switch result {
                            case .success(let review):
                                firstReview = review
                                self.totalReviews = firstReview.totalReviews
                                FirestoreManager.shared.getShopList(kind: self.shopKind, category: self.shopCategory, shopID: self.shopID) { [weak self] result in
                                    guard let self = self else { return }
                                    
                                    switch result {
                                    case .success(let shops):
                                        self.recommendationShops = shops
                                        shopList = shops
                                        var shopIDs: [String] = []
                                        var shopTitles: [String] = []
                                        var shopImages: [String] = []
                                        var shopScores: [Double] = []
                                        let shopCount: Int = shops.count

                                        for shop in shopList {
                                            shopIDs.append(shop.id)
                                            shopTitles.append(shop.title)
                                            shopImages.append(shop.imageURL)
                                            shopScores.append(shop.score)
                                        }
                                        
                                        var shopInfo = ShopInfo(id: UUID(), shopID: self.shopID, shopImageURL: self.shopImageURL, shopTitle: self.shopTitle, shopAddress: self.shopAddress, shopOpeningTime: self.shopOpenTime, eventID: firstEvent.id, eventTitle: firstEvent.title, eventDescription: firstEvent.description, eventStartDate: firstEvent.startDate, eventEndDate: firstEvent.endDate, eventPrice: firstEvent.price, eventOriginalPirce: firstEvent.originalPrice, eventImageURL: firstEvent.imageURL, productImageURLs: productImages, reviewUsername: firstReview.username, reviewAvatarImageURL: firstReview.avatarImageURL, reviewContent: firstReview.content, reviewImageURLs: firstReview.imageURLs, reviewAmount: firstReview.totalReviews, reviewLikeAmount: firstReview.likeAmount, recommendShopIDs: shopIDs, recommendShopTitles: shopTitles, recommendShopImages: shopImages, recommendShopScores: shopScores)
                                        for i in Array(0..<5) {
                                            if i == 2 || i == 4 {
                                                var index = 0
                                                if i == 2 { index = 3 } else { index = shopCount }
                                                var list: [ShopInfo] = []
                                                for _ in Array(0..<index) {
                                                    shopInfo.id = UUID()
                                                    list.append(shopInfo)
                                                }
                                                self.dataList.append(list)
                                            } else {
                                                shopInfo.id = UUID()
                                                self.dataList.append([shopInfo])
                                            }
                                        }
                                        self.updateData(on: self.dataList)
                                        
                                    case .failure(let error):
                                        self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
                                    }
                                }
                            case .failure(let error):
                                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
                            }
                        }
                    case .failure(let error):
                        self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
                    }
                }
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
        }
    }
}
    

extension ShopInfoVC {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionKind = SectionKind(rawValue: sectionIndex) else { return nil }
            let columnHeight = sectionKind.height
            let columns       = sectionKind.columns
            let fracWidth: CGFloat   = 1 / CGFloat(columns)

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fracWidth),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupHeight = NSCollectionLayoutDimension.absolute(columnHeight)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 11
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 11, trailing: 13)

            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(5))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: ShopInfoVC.sectionHeaderElementKind, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}


extension ShopInfoVC {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = FLColors.white
        collectionView.register(ShopCell.self, forCellWithReuseIdentifier: ShopCell.reuseID)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.reuseID)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reuseID)
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.reuseID)
        collectionView.register(ShopInfoSV.self, forSupplementaryViewOfKind: ShopInfoVC.sectionHeaderElementKind, withReuseIdentifier: ShopInfoSV.reuseID)

        collectionView.delegate = self
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, ShopInfo>(collectionView: collectionView) {
            (collectionView, indexPath, shopInfo) -> UICollectionViewCell? in
            
            let bottomLine = CALayer()
            bottomLine.backgroundColor = FLColors.lightGray.cgColor
            
            let section = SectionKind(rawValue: indexPath.section)!
            
            switch section {
            case .shop:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCell.reuseID, for: indexPath) as? ShopCell {
                    cell.set(title: shopInfo.shopTitle, address: shopInfo.shopAddress, time: shopInfo.shopOpeningTime, imageURL: shopInfo.shopImageURL)
                    cell.layer.shadowColor     = FLColors.black.cgColor
                    cell.layer.shadowOpacity   = 0.06
                    cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
                    cell.layer.masksToBounds   = false
                    cell.layer.shadowRadius    = 3
                    return cell
                } else { fatalError("Cannot create new cell") }
            case .event:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.reuseID, for: indexPath) as? EventCell {
                    cell.set(title: shopInfo.eventTitle, description: shopInfo.eventDescription, startDate: shopInfo.eventStartDate, endDate: shopInfo.eventEndDate, price: shopInfo.eventPrice, originalPrice: shopInfo.eventOriginalPirce, imageURL: shopInfo.eventImageURL)
                    cell.layer.shadowColor     = FLColors.black.cgColor
                    cell.layer.shadowOpacity   = 0.06
                    cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
                    cell.layer.masksToBounds   = false
                    cell.layer.shadowRadius    = 3
                    return cell
                } else { fatalError("Cannot create new cell") }
            case .product:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell {
                    cell.set(imageURL: shopInfo.productImageURLs[indexPath.item])
                    bottomLine.frame = CGRect(x: 0.0, y: cell.frame.height - 1, width: cell.frame.width, height: 1.0)
                    cell.layer.addSublayer(bottomLine)
                    return cell
                } else { fatalError("Cannot create new cell") }
            case .review:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reuseID, for: indexPath) as? ReviewCell {
                    cell.set(avatarImageURL: shopInfo.reviewAvatarImageURL, username: shopInfo.reviewUsername, content: shopInfo.reviewContent, likeCount: shopInfo.reviewLikeAmount, reviewImageURLs: shopInfo.reviewImageURLs)
                    bottomLine.frame = CGRect(x: 0.0, y: cell.frame.height - 1, width: cell.frame.width, height: 1.0)
                    cell.layer.addSublayer(bottomLine)
                    return cell
                } else { fatalError("Cannot create new cell") }
            case .recommendation:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.reuseID, for: indexPath) as? RecommendationCell {
                    cell.set(title: shopInfo.recommendShopTitles[indexPath.item], imageURL: shopInfo.recommendShopImages[indexPath.item], score: shopInfo.recommendShopScores[indexPath.item])
                    cell.layer.shadowColor     = FLColors.black.cgColor
                    cell.layer.shadowOpacity   = 0.06
                    cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
                    cell.layer.masksToBounds   = false
                    cell.layer.shadowRadius    = 3
                    return cell
                } else { fatalError("Cannot create new cell") }
            }
        }
        dataSource.supplementaryViewProvider = { ( collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: ShopInfoSV.reuseID, for: indexPath) as? ShopInfoSV else { fatalError("Cannot create new supplementary") }
            let section = indexPath.section
            let sectionTitle = self.sectionTitles[section]
            switch section {
            case 0:
                supplementaryView.removeView()
            case 1:
                supplementaryView.set(title: sectionTitle, hasButton: false)
            case 2, 4:
                supplementaryView.set(title: sectionTitle, hasButton: true)
            case 3:
                supplementaryView.set(title: sectionTitle, hasButton: true, commentCount: self.totalReviews)
            default:
                break
            }
            supplementaryView.backgroundColor = FLColors.white
            return supplementaryView
        }
    }
    
    
    func updateData(on shopInfo: [[ShopInfo]]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, ShopInfo>()
        var i = 0
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(shopInfo[i])
            i += 1
        }
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
}


extension ShopInfoVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = recommendationShops
        let shop        = activeArray[indexPath.item]
        let destVC      = ShopInfoVC()
        destVC.shopCategory = shop.category
        destVC.shopImageURL = shop.imageURL
        destVC.shopOpenTime = shop.openingTime
        destVC.shopTitle    = shop.title
        destVC.shopID       = shop.id
        destVC.shopAddress  = shop.address
        destVC.shopKind     = shop.kind
        navigationController?.pushViewController(destVC, animated: true)
    }
}
