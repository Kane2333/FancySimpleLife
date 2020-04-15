//
//  HomeVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: FLDataLoadingVC {
    
    enum Section { case main }
    
    let locationManager = CLLocationManager()
    
    static  let sectionHeaderElementKind    = "section-header-element-kind"
    private let containerView               = UIView()
    private let locationView                = UIView()
    private let homeLocationVC              = HomeLocationVC()
    private let searchBar                   = UIView()
    private let adView                      = UIView()
    
    var location: CLLocation?
    
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var isPerformingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: 1140)
    lazy var scrollView: FLScrollView = {
        let scrollView = FLScrollView(view: view, containerView: containerView, contentViewSize: contentViewSize, bounces: true)
        return scrollView
    }()
    
    var categoryCollectionView: UICollectionView!
    var tuanGoCollectionView: UICollectionView!
    var categrotyDataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    var tuanGoDataSource: UICollectionViewDiffableDataSource<Section, TuanGo>!
    var categoryImages: [UIImage] = [FLImages.foodDrink!, FLImages.shengXian!, FLImages.fun!, FLImages.travel!]
    var tuanGoList: [TuanGo]      = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FLColors.white
        checkLocationSevices()
        
        configureCategoryCollectionView()
        configureTuanGoCollectionView()
        configureUI()
        
        add(childVC: homeLocationVC, to: locationView)
        add(childVC: SearchBarVC(), to: searchBar)
        add(childVC: FLAdvertVC(), to: adView)

        updateCategoryData()
        configureCategoryDataSource()
        configureTuanGoDataSource()
        
        /*
        db.collection("Shop").addDocument(data: ["imageURL": "https://firebasestorage.googleapis.com/v0/b/mysimpletest-a3323.appspot.com/o/shop11.png?alt=media&token=142b7ef3-949e-4032-a028-9dea24e724fe", "title": "寿司次郎", "address": "11 Star Alley, Melbourne, VIC, 3000", "category": "food", "location": [-37.812597, 144.965574], "openingTime": "10:30-21:00", "priority": "13", "score": 4.3, "secondaryTitle": "做最好吃的寿司", "kind": "日料"])
*/
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        getTuanGoItems()
    }
    
    
    private func configureUI() {
        view.addSubview(scrollView)
        containerView.addSubviews(locationView, searchBar, adView, categoryCollectionView, tuanGoCollectionView)
        
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
            tuanGoCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tuanGoCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tuanGoCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    
    func configureCategoryCollectionView() {
        categoryCollectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: UIHelper.createHorizontalFlowLayoutOneSection(in: containerView))
        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseID)
        categoryCollectionView.backgroundColor = FLColors.white
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.delegate = self
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
        DispatchQueue.main.async {self.categrotyDataSource.apply(snapshot, animatingDifferences: false)}
    }
    
    
    
    func configureTuanGoCollectionView() {
        tuanGoCollectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: containerView))
        tuanGoCollectionView.register(HomeTuanGoCell.self, forCellWithReuseIdentifier: HomeTuanGoCell.reuseID)
        tuanGoCollectionView.register(FLHeaderSV.self, forSupplementaryViewOfKind: HomeVC.sectionHeaderElementKind, withReuseIdentifier: FLHeaderSV.reuseID)
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
            cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
            cell.layer.shadowRadius    = 3
            cell.delegate              = self
            return cell
        }
        
        tuanGoDataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in

            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FLHeaderSV.reuseID,
                for: indexPath) as? FLHeaderSV else { fatalError("Cannot create new supplementary") }
            supplementaryView.set(title: "团购", hasButton: false, hasDeleteButton: false)
            supplementaryView.backgroundColor       = FLColors.white
            return supplementaryView
        }
    }
    
    
    func updateTuanGoData(on tuanGoItems: [TuanGo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TuanGo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tuanGoItems)
        DispatchQueue.main.async {self.tuanGoDataSource.apply(snapshot, animatingDifferences: false)}
    }
    
    
    func getTuanGoItems() {
        showLoadingView()
        FirestoreManager.shared.getTuanGoList(for: "homepage") { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let tuanGoList):
                self.tuanGoList = tuanGoList
                
                let count = self.tuanGoList.count
                var height: CGFloat = 0
                if count % 2 != 0 {
                    height = CGFloat((count / 2) + 1) * 235
                } else {
                    height = CGFloat(count / 2) * 235
                }
                self.scrollView.set(height: 435 + height)
                
                self.updateTuanGoData(on: self.tuanGoList)
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
        }
    }
    
    
    func updateAddress() {
        if location != nil {
            if let placemark = placemark {
                homeLocationVC.setLocation(location: getAddress(from: placemark))
                
            } else if isPerformingReverseGeocoding {
                homeLocationVC.setLocation(location: "Searching for address..")
            } else if lastGeocodingError != nil {
                homeLocationVC.setLocation(location: "Error finding a valid address")
            } else {
                homeLocationVC.setLocation(location: "Address Not Found")
            }
            
        } else {
            homeLocationVC.setLocation(location: "Location is unavailable...")
        }
    }
    
    
    func getAddress(from placemark: CLPlacemark) -> String {
        var address = ""
        if let street1 = placemark.subThoroughfare { address += street1 + " " }
        if let street2 = placemark.thoroughfare { address += street2 + " " }
        if let city = placemark.locality { address += city + " " }
        if let state = placemark.administrativeArea { address += state + " " }
        if let postalCode = placemark.postalCode { address += postalCode + " " }
        if let country = placemark.country { address += country }
        return address
    }
    
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    
    func checkLocationSevices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            presentFLAlertOnMainThread(title: "未开启定位服务", message: "请前往系统设置开启定位服务，来获取更好体验吧！😄", buttonTitle: "确认")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
            presentFLAlertOnMainThread(title: "未允许定位服务", message: "请前往系统设置允许本应用取用位置, 来享受更好的体验吧！😄", buttonTitle: "确认")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            updateAddress()

        @unknown default:
            presentFLAlertOnMainThread(title: "授权获取位置错误", message: "无法获取您的位置授权", buttonTitle: "确认")
        }
    }
}


extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        updateAddress()
        if location != nil {
            if !isPerformingReverseGeocoding {
                print("*** Start performing geocoding..")
                isPerformingReverseGeocoding = true
                geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                    self.lastGeocodingError = error
                    if error == nil, let placemarks = placemarks, !placemarks.isEmpty {
                        self.placemark = placemarks.last!
                    } else {
                        self.placemark = nil
                    }
                    self.isPerformingReverseGeocoding = false
                    self.updateAddress()
                }
            }
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let options = ["餐饮", "生鲜", "娱乐", "旅行"]
        let shopVC = ShopVC(category: options[indexPath.item])
        
        navigationController?.pushViewController(shopVC, animated: true)
        //tabBarController?.selectedIndex = 1
        //tabBarController?.selectedViewController = shopVC
    }
}


extension HomeVC: HomeTuanGoCellDelegate {
    func didRequestToAddToCart() {
        presentAddToCartSuccessView()
    }
}
