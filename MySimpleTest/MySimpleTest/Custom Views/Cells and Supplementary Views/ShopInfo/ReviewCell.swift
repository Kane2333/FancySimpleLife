//
//  ReviewCell.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    static let reuseID = "ReviewCell"
    
    enum Section { case main }
    
    private var imageURLs: [String] = []
    
    private let label               = FLTitleLabel(textAlignment: .center, fontSize: 14, textColor: FLColors.gray, fontWeight: .medium)
    private let avatarImageView     = FLRegularImageView(frame: .zero)
    private let usernameLabel       = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.gray, fontWeight: .medium)
    private let contentLabel        = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.black, fontWeight: .regular)
    private let likeButton          = FLButton()
    private let countLabel          = FLTitleLabel(textAlignment: .center, fontSize: 10, textColor: FLColors.black, fontWeight: .regular)
    
    private var isOn: Bool          = false
    
    private var collectionView: UICollectionView!                                = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        configureUI()
        configureDataSource()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(shopInfo: ShopInfo) {
        if shopInfo.reviewAvatarImageURL == nil {
            self.removeSubViews(avatarImageView, usernameLabel, contentLabel, likeButton, collectionView, countLabel)
            addSubview(label)
            label.text = "此功能尚未开放，敬请期待！"
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: contentView.topAnchor),
                label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                label.widthAnchor.constraint(equalTo: label.widthAnchor),
                label.heightAnchor.constraint(equalToConstant: 22)
            ])
        } else {
            avatarImageView.downloadImage(fromURL: shopInfo.reviewAvatarImageURL!)
            usernameLabel.text  = shopInfo.reviewUsername
            contentLabel.text   = shopInfo.reviewContent
            countLabel.text     = "\(Int(shopInfo.reviewLikeAmount!))"
            if shopInfo.reviewImageURLs!.count == 0 {
                self.removeSubViews(collectionView)
            } else {
                imageURLs       = shopInfo.reviewImageURLs!
                updateData(images:imageURLs)
            }
        }
    }
    
    
    func activateLikeButton(bool: Bool) {
        isOn = bool
        likeButton.isSelected = isOn
    }
    
    
    @objc func likeButtonPressed() {
        activateLikeButton(bool: !isOn)
    }
    
    
    private func configureUI() {
        addSubviews(avatarImageView, usernameLabel, contentLabel, likeButton, countLabel)
        contentLabel.adjustsFontSizeToFitWidth  = false
        usernameLabel.adjustsFontSizeToFitWidth = false
        contentLabel.numberOfLines = 2
        likeButton.backgroundColor  = FLColors.white
        likeButton.setImage(FLImages.smallHeart, for: .normal)
        likeButton.setImage(FLImages.smallRedHeart, for: .selected)
        likeButton.addTarget(self, action: #selector(ShopCell.likeButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            avatarImageView.heightAnchor.constraint(equalToConstant: 34),
            avatarImageView.widthAnchor.constraint(equalToConstant: 34),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 6),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 17),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            contentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            contentLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38),
            contentLabel.heightAnchor.constraint(equalToConstant: 34),
            
            likeButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 14),
            likeButton.widthAnchor.constraint(equalToConstant: 17),
            
            countLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 1),
            countLabel.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 14),
            countLabel.widthAnchor.constraint(equalToConstant: 11),
            
            collectionView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 40),
            collectionView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
    }
    
    
    
}

extension ReviewCell {
    func createLayout() -> UICollectionViewLayout {
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.itemSize                 = CGSize(width: 39, height: 39)
        flowLayout.minimumInteritemSpacing  =  11
        return flowLayout
    }
}


extension ReviewCell {
    func configureCollectionView() {
        collectionView                                              = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor                              = FLColors.white
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.register(ReviewImageCell.self, forCellWithReuseIdentifier: ReviewImageCell.reuseID)
        addSubview(collectionView)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, imageURL: String) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewImageCell.reuseID,
                for: indexPath) as? ReviewImageCell else { fatalError("Cannot create new cell") }
            
            cell.set(imageURL: imageURL)
        
            return cell
        }
    }
    
    func updateData(images: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(images)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
