//
//  AccountVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AccountVC: UIViewController {
    
    var isLoggedIn: Bool! { return Auth.auth().currentUser != nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        if !isLoggedIn {
            DispatchQueue.main.async {
                self.add(childVC: SignInVC(), to: self.view)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        if !isLoggedIn {
            DispatchQueue.main.async {
                self.add(childVC: SignInVC(), to: self.view)
            }
        }
    }

}

