//
//  MapVC.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/14.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class MapVC: FLDataLoadingVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showEmptyStateView(with: "此功能尚未开放，敬请期待😊", in: view)
    }
}
