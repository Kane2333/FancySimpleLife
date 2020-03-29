//
//  FLAdvertVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLAdvertVC: UIViewController {
    
    var sliderCollectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var dataSource: UICollectionViewDiffableDataSource<Int, AdImage>!
    let pageControl         = FLPageContorl()
    var currentIndex        = 0
    var timer               = Timer()
    var images: [AdImage]   = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        getImages()
    }
    
    
    func configureUI() {
        flowLayout = UIHelper.createAdImageFlowLayout(in: view)
        sliderCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        sliderCollectionView.register(AdvertCell.self, forCellWithReuseIdentifier: AdvertCell.reuseID)
        view.addSubviews(sliderCollectionView, pageControl)
  
        sliderCollectionView.layer.cornerRadius     = 3
        sliderCollectionView.layer.masksToBounds    = true
        sliderCollectionView.autoresizesSubviews    = true
        sliderCollectionView.showsHorizontalScrollIndicator             = false
        sliderCollectionView.isPagingEnabled                            = true
        sliderCollectionView.isScrollEnabled                            = true
        sliderCollectionView.isPrefetchingEnabled                       = true
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            sliderCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            sliderCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            sliderCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sliderCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            pageControl.centerYAnchor.constraint(equalTo: sliderCollectionView.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func activateScrollImages() {
        pageControl.numberOfPages   = images.count
        pageControl.currentPage     = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func changeImage() {
        if currentIndex < images.count {
            let indexPath = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
            currentIndex += 1
        }
        else {
            currentIndex = 0
            let indexPath = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
        }
    }
    
    
    func getImages() {
        FirestoreManager.shared.getAdList(for: "homepage") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageList):
                self.images = imageList
                self.activateScrollImages()
                self.updateData()
            case .failure(let error):
                self.presentFLAlertOnMainThread(title: "错误！", message: error.rawValue, buttonTitle: "确认")
            }
        }

    }
    

    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: sliderCollectionView, cellProvider: { (sliderCollectionView, indexPath, adImageItem) -> UICollectionViewCell? in
            let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier:AdvertCell.reuseID, for: indexPath) as! AdvertCell
            cell.set(imageURL: adImageItem.imageURL)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AdImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(images)
        DispatchQueue.main.async{self.dataSource.apply(snapshot, animatingDifferences: false)}
    }
}


