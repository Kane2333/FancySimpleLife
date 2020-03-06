//
//  SignupVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    var usernameTextField = FSLTextField(placeHolderText: "  Username", textAlignment: .left)
    var emailTextField = FSLTextField(placeHolderText: "  Email", textAlignment: .left)
    var passwordTextField = FSLTextField(placeHolderText: "  Password", textAlignment: .left)
    var passwordConfirmTextField = FSLTextField(placeHolderText: "  Confirm Password", textAlignment: .left)
    var inviteCodeTextField = FSLTextField(placeHolderText: "  Invite Code", textAlignment: .left)
    var errorMessage:String!

    let createBtn = FSLButton(backgroundImage: nil, title: "Create a new account", titleColor: .systemBlue, titleHorizontalAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTextFields()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Private Method
    private func configureTextFields() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmTextField)
        view.addSubview(inviteCodeTextField)
        view.addSubview(createBtn)
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordConfirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 40),
            
            inviteCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inviteCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            inviteCodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            inviteCodeTextField.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: padding),
            inviteCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            createBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createBtn.topAnchor.constraint(equalTo: inviteCodeTextField.bottomAnchor, constant: padding),
            createBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        createBtn.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
    }
    
    @objc func createNewAccount() {
        print("Button pressed")
        // Check that all fields are filled in
        var validateMessage = ""
        var isValid = true
        
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordConfirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            validateMessage += "Please fill in all fields"
            isValid = false
        }
        
        // Validate the fields
        /*if !emailTextField.text!.isValidEmail {
            validateMessage += "\nEmail address entered is invalid."
            isValid = false
        }*/
        
        if !passwordTextField.text!.isValidPassword {
            validateMessage += "Password entered is invalid."
            isValid = false
        }
        
        if !passwordTextField.text!.isValidPassword {
            validateMessage += "Confirm password  entered is invalid."
            isValid = false
        }
        
        guard isValid else {
            presentFSLAlertOnMainThread(title: "Validation Message", message: validateMessage, buttonTitle: "Ok")
            return
        }
        
        print("Validation: OK")
        
        // Create cleaned versions of the data
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inviteCode = inviteCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordConfirmTextField.text!) { (result, err) in
            if err != nil {
                // Their was an error creating the user
                print("Error creating user")
            } else {
                //User was created successfully, now store the user info
                let db = Firestore.firestore()
                
                db.collection("users").document(result!.user.uid).setData([
                    "uid": result!.user.uid,
                    "username": username,
                    "inviteCode": inviteCode
                ]) { (error) in
                    if error != nil {
                        print("There was an error occurred.")
                    }
                }
            }
        }
        
        // Transition to the home screen
        let homeVC = HomeVC()
        navigationController?.pushViewController(homeVC, animated: false)
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return true
    }
}

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-0a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordFormat = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}
