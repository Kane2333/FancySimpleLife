//
//  FLScrollView.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLScrollView: UIScrollView {

    var containerView: UIView?
    
    init(view: UIView, containerView: UIView, contentViewSize: CGSize, bounces: Bool = true) {
        super.init(frame: .zero)
        
        backgroundColor = FLColors.white
        frame = view.bounds
        contentSize = contentViewSize
        autoresizingMask = .flexibleHeight
        showsVerticalScrollIndicator = false
        self.bounces = bounces
        
        containerView.backgroundColor = FLColors.white
        containerView.frame.size = contentViewSize
        
        addSubview(containerView)
        
        self.containerView = containerView
    }
    
    func set(height: CGFloat) {
        let width = contentSize.width
        contentSize = CGSize(width: width, height: height)
        containerView?.frame.size = contentSize
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
