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
}

class FLHeaderSV: UICollectionReusableView {
    
    static let reuseID  = "FLHeaderSV"
    
    weak var delegate: FLHeaderSVDelegate!
    
    private let titleLabel      = FLTitleLabel(textAlignment: .center, fontSize: 16, textColor: FLColors.black, fontWeight: .medium)
    private let countLabel      = FLTitleLabel(textAlignment: .left, fontSize: 12, textColor: FLColors.black, fontWeight: .regular)
    private let button          = FLButton(title: "更多", textColor: FLColors.red, fontSize: 12)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func removeView() {
        let views: [UIView] = [titleLabel, countLabel, button]
        for view in views {
            view.removeFromSuperview()
        }
    }
    
    
    func set(title: String, hasButton: Bool, commentCount: Int?=nil) {
        configure()
        titleLabel.text = title
        countLabel.removeFromSuperview()
        button.removeFromSuperview()
        if hasButton {
            button.removeTarget(self, action: nil, for: .allTouchEvents)
            configureButton()
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),

        ])
    }
}
