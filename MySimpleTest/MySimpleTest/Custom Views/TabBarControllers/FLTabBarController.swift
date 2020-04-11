//
//  FLTabbarController.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLTabBarController: UITabBarController {
    
    let offset: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = FLColors.red
        viewControllers = [createHomeNC(), createShopNC(), createWalletNC(), createAccountNC()]
    }
    

    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "首页", image: FLImages.home, tag: 0)
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        homeVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: offset)

        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createShopNC() -> UINavigationController {
        let shopVC = ShopVC()
        shopVC.title = "Shop"
        shopVC.tabBarItem = UITabBarItem(title: "商店", image: FLImages.shop, tag: 1)
        shopVC.tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        shopVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: offset)
        
        return UINavigationController(rootViewController: shopVC)
    }

    
    func createWalletNC() -> UINavigationController {
        let walletVC = WalletVC()
        walletVC.title = "Cart"
        walletVC.tabBarItem = UITabBarItem(title: "购物车", image: FLImages.cart, tag: 2)
        walletVC.tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        walletVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: offset)
        
        return UINavigationController(rootViewController: walletVC)
    }
    
    
    func createAccountNC() -> UINavigationController {
        let accountVC = AccountVC()
        accountVC.title = "Account"
        accountVC.tabBarItem = UITabBarItem(title: "我", image: FLImages.account, tag: 3)
        accountVC.tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        accountVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: offset)
        
        return UINavigationController(rootViewController: accountVC)
    }
}
