//
//  FLTabbarController.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/26.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

class FLTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createHomeNC(), createShopNC(), createWalletNC(), createAccountNC()]
    }
    

    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createShopNC() -> UINavigationController {
        let shopVC = ShopVC()
        shopVC.title = "Shop"
        shopVC.tabBarItem = UITabBarItem(title: "Shop", image: UIImage(systemName: "cart"), tag: 1)
        
        return UINavigationController(rootViewController: shopVC)
    }

    
    func createWalletNC() -> UINavigationController {
        let walletVC = WalletVC()
        walletVC.title = "Wallet"
        walletVC.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(systemName: "briefcase"), tag: 2)
        
        return UINavigationController(rootViewController: walletVC)
    }
    
    
    func createAccountNC() -> UINavigationController {
        let accountVC = AccountVC()
        accountVC.title = "Account"
        accountVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), tag: 3)
        
        return UINavigationController(rootViewController: accountVC)
    }
}
