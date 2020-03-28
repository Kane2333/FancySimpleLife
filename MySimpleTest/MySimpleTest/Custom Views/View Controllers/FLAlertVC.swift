//
//  FLAlertVC.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLAlertVC: UIViewController {

    let containerView = FLAlertContainerView()
    let titleLabel = FLTitleLabel(textAlignment: .center, fontSize: 20, textColor: FLColors.black, fontWeight: .bold)
    let bodyLabel = FLTitleLabel(textAlignment: .center, fontSize: 12, textColor: FLColors.gray, fontWeight: .regular)
    let actionButtion = FLButton(backgroundColor: FLColors.red, title: "确认", titleColor: FLColors.white)
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        // Nil coalescing -> default title label
        titleLabel.text = alertTitle ?? "错误"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    // message will be between title label and the button, so confiure the button first
    func configureActionButton() {
        containerView.addSubview(actionButtion)
        actionButtion.setTitle(buttonTitle ?? "确认", for: .normal)
        actionButtion.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButtion.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButtion.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant : padding),
            actionButtion.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -padding),
            actionButtion.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
        
    func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        bodyLabel.text = message ?? "无法完成请求"
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButtion.topAnchor, constant: -12),
        ])
           
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


