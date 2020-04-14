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
    
    let label1 = FLTitleLabel(frame: .zero)
    let headView = FSLSignInHeadView(text: "欢迎您，\n注册成为我们的用户")
    let emailTextField = FSLTextField(iconName: "mail")
    let passwordTextField = FSLTextField(iconName: "unlock")
    let confirmPasswordTextField = FSLTextField(iconName: "square_check")
    let inviteCodeTextField = FSLTextField(iconName: "favor")
    let validationMessageLabel = FLTitleLabel(textAlignment: .left, fontSize: 12.0)
    let forgetPasswordLabel = FLTitleLabel(textAlignment: .left, fontSize: 12.0)
    let nextStepButton = FLButton(backgroundColor: .red, title: "下一步", titleColor: .systemBackground)
    let backButton = FLUnderlineTextButton(title: "已拥有账户?", titleColor: .black, fontSize: 12)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureHeadView()
        configureTextField()
        configureValidationMessage()
        configureButtons()
        
        createDismissKeyboardTapGesture()
    }
    
    // MARK: Private Method
    private func configure() {
        view.backgroundColor = FLColors.FSLbackgroundColor
    }
    
    private func configureHeadView() {
        view.addSubview(headView)
        headView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        let padding:CGFloat = 14
        
        view.addSubviews(emailTextField, passwordTextField, confirmPasswordTextField, inviteCodeTextField)
       
        emailTextField.placeholder = "请输入邮箱"
        passwordTextField.placeholder = "请输入密码"
        confirmPasswordTextField.placeholder = "请确认密码"
        inviteCodeTextField.placeholder = "请输入邀请码"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addRightIconView(imageNamed: "visible")
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.addRightIconView(imageNamed: "visible")
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: headView.bottomAnchor, constant: 70),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            inviteCodeTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            inviteCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            inviteCodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            inviteCodeTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureValidationMessage() {
        view.addSubview(validationMessageLabel)
        validationMessageLabel.text = TestMessages.defaultTestMessage
        validationMessageLabel.textColor = .red
        
        NSLayoutConstraint.activate([
            validationMessageLabel.topAnchor.constraint(equalTo: inviteCodeTextField.bottomAnchor, constant: 10),
            validationMessageLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            validationMessageLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            validationMessageLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureButtons() {
        view.addSubviews(nextStepButton, backButton)
        
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextStepButton.topAnchor.constraint(equalTo: validationMessageLabel.bottomAnchor, constant: 20),
            nextStepButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextStepButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            nextStepButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            nextStepButton.heightAnchor.constraint(equalToConstant: 44),
                
            backButton.topAnchor.constraint(equalTo: nextStepButton.bottomAnchor, constant: 8),
            backButton.trailingAnchor.constraint(equalTo: nextStepButton.trailingAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 72),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func nextStep() {
        
        let fillAcccountDetailVC = FillAcccountDetailVC()
        navigationController?.pushViewController(fillAcccountDetailVC, animated: false)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: false)
    }
    
    /*private func configureTextFields() {
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
    }*/
    
    func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func createNewAccount() {
        print("Button pressed")
        // Check that all fields are filled in
        var validateMessage = ""
        var isValid = true
        
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
            presentFLAlertOnMainThread(title: "Validation Message", message: validateMessage, buttonTitle: "Ok")
            return
        }
        
        print("Validation: OK")
        
        // Create cleaned versions of the data
        let inviteCode = inviteCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: emailTextField.text!, password: confirmPasswordTextField.text!) { (result, err) in
            if err != nil {
                // Their was an error creating the user
                print("Error creating user")
            } else {
                //User was created successfully, now store the user info
                let db = Firestore.firestore()
                
                db.collection("users").document(result!.user.uid).setData([
                    "uid": result!.user.uid,
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

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return true
    }
}

/*extension String {
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
}*/
