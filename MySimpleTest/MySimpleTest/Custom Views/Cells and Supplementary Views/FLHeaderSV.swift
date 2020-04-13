//
//  FLHeaderSV.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/7.
//  Copyright © 2020 FancyLife. All rights reserved.
//


import UIKit

protocol FLHeaderSVDelegate: class {
    func requestToPushProductVC()
    func requestToPushEventVC()
    func requestToClearSearchHistory()
}

class FLHeaderSV: UICollectionReusableView {
    
    static let reuseID  = "FLHeaderSV"
    
    weak var delegate: FLHeaderSVDelegate!
    
    private let titleLabel      = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.black, fontWeight: .medium)
    private let countLabel      = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.black, fontWeight: .regular)
    private let button          = FLButton(title: "更多", textColor: FLColors.red, fontSize: 12)
    private let deleteButton    = FLButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func removeView() {
        let views: [UIView] = [titleLabel, countLabel, button, deleteButton]
        for view in views {
            view.removeFromSuperview()
        }
    }
    
    
    func set(title: String, hasButton: Bool, hasDeleteButton: Bool, commentCount: Int?=nil) {
        configure()
        titleLabel.text = title
        countLabel.removeFromSuperview()
        button.removeFromSuperview()
        deleteButton.removeFromSuperview()
        
        if hasButton {
            button.removeTarget(self, action: nil, for: .allTouchEvents)
            configureButton()
        }
        
        if hasDeleteButton {
            deleteButton.removeTarget(self, action: nil, for: .allTouchEvents)
            configureDeleteButton()
        }
        
        if commentCount != nil {
            configureCountLabel()
            countLabel.text = "(\(Int(commentCount!)))条"
        }
    }
    
    
    func addTargetToPushProductVC() {
        button.addTarget(self, action: #selector(pushProductVC), for: .touchUpInside)
    }
    
    
    @objc func pushProductVC() {
        delegate.requestToPushProductVC()
    }
    
    func addTargetToPushEventVC() {
        button.addTarget(self, action: #selector(pushEventVC), for: .touchUpInside)
    }
    
    
    @objc func pushEventVC() {
        delegate.requestToPushEventVC()
    }
    
    func addTargetToClearSearchHistory() {
        deleteButton.addTarget(self, action: #selector(clearSearchHistory), for: .touchUpInside)
    }
    
    @objc func clearSearchHistory() {
        delegate.requestToClearSearchHistory()
    }
    
    
    private func configureButton() {
        addSubview(button)
        button.titleLabel?.textAlignment = .right
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 17),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.widthAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
    
    private func configureDeleteButton() {
        addSubview(deleteButton)
        deleteButton.setBackgroundImage(FLImages.trashBin, for: .normal)
        
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    
    private func configureCountLabel() {
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 7),
            countLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 17),
            countLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configure() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
        ])
    }
}
