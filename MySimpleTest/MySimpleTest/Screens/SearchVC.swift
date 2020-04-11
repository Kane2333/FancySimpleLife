//
//  SearchVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private let searchController    = UISearchController()
    private var textList:[[String]] = [[],[]]
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FLColors.white
        configureSearchController()
        configureCollectionView()
        
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createDynamicGridLayout(in: view))
        //collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.reuseID)
        collectionView.register(FLHeaderSV.self, forSupplementaryViewOfKind: SearchVC.sectionHeaderElementKind, withReuseIdentifier: FLHeaderSV.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = FLColors.white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    
    private func updateData(on texts: [[String]] ) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        for section in [0,1] {
            if !texts[section].isEmpty {
                snapshot.appendSections([section])
                snapshot.appendItems(texts[section])
            }
        }
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    
    func getTexts() {
        
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
 
}

extension SearchVC: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { searchController.searchBar.becomeFirstResponder()}
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            return
        }
        PersistenceManager.updateWith(history: filter, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            guard error != nil else { return }
        }
    }
}

extension SearchVC: FLHeaderSVDelegate {
    func requestToPushProductVC() {}
    
    func requestToPushEventVC() {}
    
    func requestToClearSearchHistory() {
        clearSearchHistory()
    }
}






