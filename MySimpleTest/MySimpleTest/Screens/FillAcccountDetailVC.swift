//
//  FillAcccountDetailVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 4/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FillAcccountDetailVC: UIViewController {
    
    let label1 = FLTitleLabel(frame: .zero)
    let headView = FSLSignInHeadView(text: "请完善，\n您的个人信息")
    let avatarImageView = FLAvatarImageView(image: "placeholderImage")
    let surnameTextField = FSLTextField(frame: .zero)
    let firstnameTextField = FSLTextField(frame:. zero)
    let phonenoTextField = FSLTextField(iconName: "square_check")
    let birthdayTextField = FSLTextField(iconName: "favor")
    let validationMessageLabel = FLTitleLabel(textAlignment: .left, fontSize: 12.0)
    let confirmButton = FLButton(backgroundColor: .red, title: "确认", titleColor: .systemBackground)
    let backButton = FLButton(backgroundColor: .red, title: "返回", titleColor: .systemBackground)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureHeadView()
        configureAvatarImageView()
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
            headView.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
    private func configureAvatarImageView() {
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: headView.bottomAnchor, constant: 30),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 146),
            avatarImageView.heightAnchor.constraint(equalToConstant: 146)
        ])
    }
    
    private func configureTextField() {
        let padding:CGFloat = 14
        
        view.addSubviews(surnameTextField, firstnameTextField, phonenoTextField, birthdayTextField)
       
        surnameTextField.placeholder = "姓"
        firstnameTextField.placeholder = "名"
        phonenoTextField.placeholder = "电话号码"
        birthdayTextField.placeholder = "生日 MM/DD/YYYY"
        
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            surnameTextField.widthAnchor.constraint(equalToConstant: 120),
            surnameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            firstnameTextField.topAnchor.constraint(equalTo: surnameTextField.topAnchor),
            firstnameTextField.leadingAnchor.constraint(equalTo: surnameTextField.trailingAnchor, constant: 15),
            firstnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            firstnameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            phonenoTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 20),
            phonenoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            phonenoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            phonenoTextField.heightAnchor.constraint(equalToConstant: 44),
            
            birthdayTextField.topAnchor.constraint(equalTo: phonenoTextField.bottomAnchor, constant: 20),
            birthdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureValidationMessage() {
        view.addSubview(validationMessageLabel)
        validationMessageLabel.text = TestMessages.defaultTestMessage
        validationMessageLabel.textColor = .red
        
        NSLayoutConstraint.activate([
            validationMessageLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 10),
            validationMessageLabel.leadingAnchor.constraint(equalTo: surnameTextField.leadingAnchor),
            validationMessageLabel.trailingAnchor.constraint(equalTo: firstnameTextField.trailingAnchor),
            validationMessageLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureButtons() {
        view.addSubviews(confirmButton, backButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: validationMessageLabel.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: birthdayTextField.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: birthdayTextField.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
                
            backButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.leadingAnchor.constraint(equalTo: birthdayTextField.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: birthdayTextField.trailingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func confirm() {
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: false)
    }
    
    /*private func configureTextFields() {
        view.addSubview(usernameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(firstnameTextField)
        view.addSubview(passwordConfirmTextField)
        view.addSubview(birthdayTextField)
        view.addSubview(createBtn)
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            surnameTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: padding),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            firstnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            firstnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            firstnameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: padding),
            firstnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordConfirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordConfirmTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: padding),
            passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 40),
            
            birthdayTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            birthdayTextField.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: padding),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 40),
            
            createBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createBtn.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: padding),
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
        
        if  surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phonenoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            validateMessage += "Please fill in all fields"
            isValid = false
        }
        
        // Validate the fields
        /*if !surnameTextField.text!.isValidEmail {
            validateMessage += "\nEmail address entered is invalid."
            isValid = false
        }*/
        
        if !firstnameTextField.text!.isValidPassword {
            validateMessage += "Password entered is invalid."
            isValid = false
        }
        
        if !firstnameTextField.text!.isValidPassword {
            validateMessage += "Confirm password  entered is invalid."
            isValid = false
        }
        
        guard isValid else {
            presentFLAlertOnMainThread(title: "Validation Message", message: validateMessage, buttonTitle: "Ok")
            return
        }
        
        print("Validation: OK")
        
        // Create cleaned versions of the data
        let inviteCode = birthdayTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: surnameTextField.text!, password: phonenoTextField.text!) { (result, err) in
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

extension FillAcccountDetailVC: UITextFieldDelegate {
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
