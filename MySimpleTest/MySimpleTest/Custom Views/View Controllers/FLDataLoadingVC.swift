//
//  FLDataLoadingVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/11.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLDataLoadingVC: UIViewController {

    var containerview: UIView!
       
    
    func showLoadingView() {
        containerview = UIView(frame: view.bounds)
        view.addSubview(containerview)
        
        containerview.backgroundColor   = .systemBackground
        containerview.alpha             = 0
        // do not want the loading view suddenly pops up
        UIView.animate(withDuration: 0.25) { self.containerview.alpha = 0.8 }
        
        let activitIndicator = UIActivityIndicatorView(style: .large)
        containerview.addSubview(activitIndicator)
        
        activitIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activitIndicator.centerYAnchor.constraint(equalTo: containerview.centerYAnchor),
            activitIndicator.centerXAnchor.constraint(equalTo: containerview.centerXAnchor)
        ])
        
        activitIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerview.removeFromSuperview()
            self.containerview = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = FLEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
