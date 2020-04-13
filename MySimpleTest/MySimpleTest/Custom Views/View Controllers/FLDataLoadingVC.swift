//
//  FLDataLoadingVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/11.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLDataLoadingVC: UIViewController {

    var containerView: UIView!
       
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        // do not want the loading view suddenly pops up
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activitIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activitIndicator)
        
        activitIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activitIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activitIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activitIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    /*
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
*/
}
