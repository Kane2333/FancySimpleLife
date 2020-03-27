//
//  UIView+Ext.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

extension UIView {
    // variadic parameters
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
