//
//  FLAdvertVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLAdvertVC: UIViewController {

    enum Section {case main}
    
    var sliderCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, UIImage>!
    let pageControl         = FLPageContorl()
    var currentIndex        = 0
    var timer               = Timer()
    var images: [UIImage]   = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        getImages()
        activateScrollImages()
    }
    
    
    func configureUI() {
        sliderCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createAdImageFlowLayout(in: view))
        view.addSubViews(sliderCollectionView, pageControl)
        
        sliderCollectionView.layer.cornerRadius     = 3
        sliderCollectionView.layer.masksToBounds    = true

        sliderCollectionView.showsVerticalScrollIndicator               = false
        sliderCollectionView.showsHorizontalScrollIndicator             = false
        sliderCollectionView.isPagingEnabled                            = true
        sliderCollectionView.isScrollEnabled                            = true
        sliderCollectionView.isPrefetchingEnabled                       = true
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints  = false
        pageControl.translatesAutoresizingMaskIntoConstraints           = false
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            sliderCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            sliderCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            sliderCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            pageControl.centerYAnchor.constraint(equalTo: sliderCollectionView.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func activateScrollImages() {
        pageControl.numberOfPages   = 3
        pageControl.currentPage     = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func changeImage() {
        if currentIndex < 3 {
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
        images    = [UIImage(named: "home1")!,
                     UIImage(named: "home2")!,
                     UIImage(named: "home3")!]
        updateData()
    }
    
    
    func configureDataSource() {
        sliderCollectionView.register(AdvertCell.self, forCellWithReuseIdentifier: AdvertCell.reuseID)
        dataSource = UICollectionViewDiffableDataSource(collectionView: sliderCollectionView, cellProvider: { (sliderCollectionView, indexPath, image) -> UICollectionViewCell? in
            let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier:AdvertCell.reuseID, for: indexPath) as! AdvertCell
            cell.set(image: image)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIImage>()
        snapshot.appendSections([.main])
        snapshot.appendItems(images)
        DispatchQueue.main.async{self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
}
