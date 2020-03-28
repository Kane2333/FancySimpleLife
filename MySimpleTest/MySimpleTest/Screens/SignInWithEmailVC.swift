//
//  SignInWithEmailVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 6/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

/*import UIKit
import FirebaseAuth

class SignInWithEmailVC: UIViewController {
    
    var emailLabel = FSLTitleLabel(textAlignment: .left, fontSize: 16)
    var passwordLabel = FSLTitleLabel(textAlignment: .left, fontSize: 16)

    var emailTextField = FSLTextField()
    var passwordTextField = FSLTextField()
    
    var signinButton = FSLButton(backgroundImage: nil, title: "Sign in", titleColor: .systemBlue, titleHorizontalAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        configureTextLabel()
        configureTextField()
        configureButton()
        createDismissKeyboardTapGesture()
    }
    

    // MARK: Private Method
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTextLabel() {
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        
        emailLabel.text = "Email"
        passwordLabel.text = "Password"
        
        NSLayoutConstraint.activate([
            emailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: 100),
            
            passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordLabel.widthAnchor.constraint(equalTo: emailLabel.widthAnchor)
        ])
    }
    
    func configureTextField() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureButton() {
        view.addSubview(signinButton)
        
        signinButton.addTarget(self, action: #selector(signin), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
        ])
    }
 
    /*func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }*/
    
    @objc func signin() {
        let email           = emailTextField.text!
        let password        = passwordTextField.text!
        
        var isValid         = true
        var validateMessage = ""
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            validateMessage += "Please fill in all fields"
            isValid         = false
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
          guard let strongSelf = self else { return }
            print(authResult!.user.uid)
        }
    }
}

extension SignInWithEmailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
*/
