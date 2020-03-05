//
//  AccountVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AccountVC: UIViewController {
    
    let loginWithEmailBtn = FSLButton(backgroundImage: UIImage(named: "Email"), title: "Log in with Email", titleColor: .white, titleHorizontalAlignment: .center)
    let loginWithFBBtn = FSLButton(backgroundImage: UIImage(named: "FB"), title: "Log in with Facebook", titleColor: .white, titleHorizontalAlignment: .center)
    let loginWithGoogleBtn = GIDSignInButton(frame: CGRect(x: 0, y:0, width: 230, height: 48))
    //FSLButton(backgroundImage: UIImage(named: "Google"), title: "Log in with Google", titleColor: .black, titleHorizontalAlignment: .center)
    //GIDSignInButton(frame: CGRect(x: 0, y:0, width: 230, height: 48))
    let signUpBtn = FSLButton(backgroundImage: nil, title: "Create a new account", titleColor: .systemBlue, titleHorizontalAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()

        //let db = Firestore.firestore()
        
        configureSigninBtns()
        confiureSignUpBtn()
    }
    
    // MARK: Private Method
    private func confiureSignUpBtn() {
        view.addSubview(signUpBtn)
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            signUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpBtn.bottomAnchor.constraint(equalTo: loginWithEmailBtn.topAnchor, constant: -padding),
            signUpBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            signUpBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        signUpBtn.addTarget(self, action: #selector(pushSignUpVC), for: .touchUpInside)
    }
    
    private func configureSigninBtns() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginWithEmailBtn)
        view.addSubview(loginWithFBBtn)
        view.addSubview(loginWithGoogleBtn)
        
        let padding:CGFloat = 20
        //let buttonHeight:CGFloat = 40
        
        print("google")
        
        loginWithGoogleBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginWithEmailBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithEmailBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginWithEmailBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginWithEmailBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            //loginWithEmailBtn.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            loginWithFBBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithFBBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginWithFBBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            //loginWithFBBtn.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginWithFBBtn.topAnchor.constraint(equalTo: loginWithEmailBtn.bottomAnchor, constant: padding),
            
            loginWithGoogleBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithGoogleBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginWithGoogleBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            //loginWithGoogleBtn.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginWithGoogleBtn.topAnchor.constraint(equalTo: loginWithFBBtn.bottomAnchor, constant: padding)
        ])
    }
    
    @objc func pushSignUpVC() {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: false)
    }

}

//db.collection("wine").addDocument(data: ["year": 2017, "type": "point-nior", "label": "Peller Estates"])

//let newDocument = db.collection("wine").document()
// CREATE
// Auto-allocate ID
//newDocument.setData(["year": 2017, "type": "gamay-nior", "label":"Peller Estates", "id": newDocument.documentID])
// Specific ID, if ID exist, then update
//db.collection("wine").document("point-nior-2017").setData(["test": "test2"])
/*db.collection("wine").addDocument(data: ["test": "test"]) { (error) in
    if let error = error {
        print("There was an error")
    } else {
        print("Operation completed successfully.")
    }
}*/

//Delete a field
//db.collection("wine").document("stoneypath-cab-2017").updateData(["type": FieldValue.delete()])

//Delet document
/*db.collection("wine").document("point-noir-2017").delete { (error) in
    
}*/

/*db.collection("wine").document("point-noir-2017").getDocument { (document, error) in
    guard let error = error else{
        return
    }
    if document != nil && document!.exists {
        let documentData = document!.data()
    }
}*/

//get all documents
/*db.collection("wine").getDocuments { (snapshot, error) in
           guard let error = error, snapshot != nil else{
               return
           }
    for document in snapshot!.documents {
        let documentData = document.data()
    }
}*/

// Getting a subset of documents
/*db.collection("wine").whereField("year": isEqualTo: 2017).getDocuments {}*/
