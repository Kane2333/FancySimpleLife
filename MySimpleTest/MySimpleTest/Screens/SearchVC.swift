//
//  SearchVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit
import CoreLocation


class SearchVC: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private let label = FLTitleLabel(textAlignment: .center, fontSize: 14, textColor: FLColors.gray, fontWeight: .regular)
    private let imageView = UIImageView(frame: .zero)
    
    private let searchController    = UISearchController()
    private var textList:[[String]] = [[],[]]
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    private var resultCollectionView: UICollectionView!
    private var resultDataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    private var resultList:[SearchResult] = []
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FLColors.white
        configureSearchController()
        configureCollectionView()
        getTexts()
        configureDataSource()
        customCancelButton()
        dismissKeyboardTapGesture()

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
    
    
    private func configureCollectionView() {
        view.removeSubViews(label, imageView, resultCollectionView)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createDynamicGridLayout(in: view))
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.reuseID)
        collectionView.register(FLHeaderSV.self, forSupplementaryViewOfKind: SearchVC.sectionHeaderElementKind, withReuseIdentifier: FLHeaderSV.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = FLColors.white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView, indexPath, text) -> UICollectionViewCell? in
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseID, for: indexPath) as? SearchCell
                else { fatalError("Cannot create new cell") }
            cell.set(text: text)
            cell.layer.masksToBounds    = false
            cell.layer.shadowRadius     = 2
            cell.backgroundColor        = FLColors.lightGray
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FLHeaderSV.reuseID,
                for: indexPath) as? FLHeaderSV else { fatalError("Cannot create new advertisment header") }
            
            switch indexPath.section {
            case 0:
                header.set(title: "热门搜索", hasButton: false, hasDeleteButton: false)
            case 1:
                header.set(title: "搜索记录", hasButton: false, hasDeleteButton: true)
                header.delegate = self
                header.addTargetToClearSearchHistory()
            default:
                break
            }
            return header
        }
    }
    
    
    private func configureNoResultUI() {
        view.removeSubViews(collectionView, resultCollectionView)
        view.addSubviews(imageView, label)
        
        imageView.image = UIImage(systemName: "exclamationmark.bubble")
        imageView.backgroundColor = FLColors.white
        imageView.tintColor = FLColors.red
        label.text = "暂无搜索结果"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 14),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.widthAnchor.constraint(equalTo: label.widthAnchor)
        ])
    }
    
    
    private func updateData(on texts: [[String]] ) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        for section in [0,1] {
            if !texts[section].isEmpty {
                snapshot.appendSections([section])
                snapshot.appendItems(texts[section])
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
    private func getTexts() {
        PersistenceManager.retrieveHistories { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let histories):
                self.textList[1] = histories
                FirestoreManager.shared.getHotSearch() { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let hotSearch):
                        self.textList[0] = hotSearch
                        self.updateData(on: self.textList)
                        
                    case .failure(let error):
                        print(error.rawValue)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func getSearchResults(keyword: String) {
        FirestoreManager.shared.getSearchResults(keyword: keyword) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let results):
                self.resultList = results
                if results.isEmpty {
                    self.configureNoResultUI()
                } else { self.updateResultData(on: results) }
                
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
        }
    }
    
    
    private func configureSearchController() {
        //searchController.searchResultsUpdater                           = self
        searchController.searchBar.delegate                             = self
        searchController.delegate                                       = self
        searchController.searchBar.placeholder                          = "搜索商家、活动"
        searchController.searchBar.setSearchFieldBackgroundImage(FLImages.searchBackgroumd, for: .normal)
        searchController.searchBar.searchTextField.layer.cornerRadius   = 3
        searchController.searchBar.searchTextField.layer.masksToBounds  = true
        searchController.obscuresBackgroundDuringPresentation           = false
        searchController.searchBar.tintColor                            = FLColors.black
        searchController.automaticallyShowsCancelButton                 = true
        searchController.searchBar.setImage(FLImages.clear, for: .clear, state: .normal)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]// ,NSAttributedString.Key.foregroundColor: FLColors.lightGray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
        navigationItem.titleView                                        = searchController.searchBar
        navigationItem.hidesBackButton                                  = true
    }
    
    
    private func customCancelButton() {
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
    
    
    private func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    private func clearSearchHistory() {
        PersistenceManager.updateWith(actionType: .remove) {[weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.textList[1].removeAll()
                self.updateData(on: self.textList)
                return
            }
            print(error)
        }
    }
    
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
 
}

extension SearchVC: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { searchController.searchBar.becomeFirstResponder()}
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        configureResultCollectionView()
        configureResultDataSource()
        getSearchResults(keyword: filter)
        
        PersistenceManager.updateWith(history: filter, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            guard error != nil else { return }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.configureCollectionView()
                self.getTexts()
                self.configureDataSource()
            }
        }
    }
}


extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
    }
}


extension SearchVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!
    }
}


extension SearchVC: FLHeaderSVDelegate {
    func requestToPushProductVC() {}
    
    func requestToPushEventVC() {}
    
    func requestToClearSearchHistory() {
        clearSearchHistory()
    }
}


extension SearchVC {
    func configureResultCollectionView() {
        view.removeSubViews(collectionView, label, imageView)
        resultCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createListFlowLayout(in: self.view, hasHeader: false))
        resultCollectionView.backgroundColor = FLColors.white
        resultCollectionView.register(ShopListCell.self, forCellWithReuseIdentifier: ShopListCell.reuseID)
        resultCollectionView.register(EventListCell.self, forCellWithReuseIdentifier: EventListCell.reuseID)
        view.addSubview(resultCollectionView)
        resultCollectionView.pinToEdges(of: view)
        resultCollectionView.delegate = self
    }
    
    
    func configureCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        cell.layer.shadowColor     = FLColors.black.cgColor
        cell.layer.shadowOpacity   = 0.06
        cell.layer.shadowOffset    = CGSize(width: 0, height: 3)
        cell.layer.masksToBounds   = false
        cell.layer.shadowRadius    = 3
        return cell
    }
    
    func configureResultDataSource() {
        resultDataSource = UICollectionViewDiffableDataSource<Int, SearchResult>(collectionView: resultCollectionView) {
            (collectionView, indexPath, searchResult) -> UICollectionViewCell? in
            
            let kind = searchResult.kind
            
            if kind == "shop" {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopListCell.reuseID, for: indexPath) as? ShopListCell {
                    let shopLocation = CLLocation(latitude: searchResult.location![0], longitude: searchResult.location![1])
                    let distance = self.userLocation?.distance(from: shopLocation) ?? 0
                    cell.set(searchResult: searchResult, distance: distance)
                    
                    return self.configureCell(cell: cell)
                } else { fatalError("Cannot create new cell") }
            } else {
                
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventListCell.reuseID, for: indexPath) as? EventListCell {
                    cell.set(searchResult: searchResult)
                    
                    return self.configureCell(cell: cell)
                } else { fatalError("Cannot create new cell") }
            }
        }
    }
    
    
    func updateResultData(on results: [SearchResult]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(results)
        DispatchQueue.main.async {
            self.resultDataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}



