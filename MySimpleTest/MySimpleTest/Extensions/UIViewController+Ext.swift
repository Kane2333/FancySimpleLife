//
//  UIViewController+Ext.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 6/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//
import UIKit

extension UIViewController {
    
    func presentFLAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = FSLAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
