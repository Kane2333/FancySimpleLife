//
//  SignInVC.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 16/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class SignInVC: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headView = FSLSignInHeadView(text: "欢迎您，\n请登录您的账户")
    let emailTextField = FSLTextField(iconName: "person")
    let passwordTextField = FSLTextField(iconName: "lock")
    let validationMessageLabel = FLTitleLabel(textAlignment: .left, fontSize: 12.0)
    let forgetPasswordLabel = FLTitleLabel(textAlignment: .left, fontSize: 12.0)
    let signInButton = FLButton(backgroundColor: .red, title: "登录", titleColor: .systemBackground)
    let signUpButton = FLButton(backgroundColor: .red, title: "注册", titleColor: .systemBackground)
    let leftLineView = FSLLine(frame: .zero)
    let rightLineView = FSLLine(frame: .zero)
    let thirdPartyLabel = FLTitleLabel(textAlignment: .center, fontSize: 18)
    //let loginWithEmailBtn = FSLButton(backgroundImage: UIImage(named: "Email"), title: "Log in with Email", titleColor: .white, titleHorizontalAlignment: .center)
    //let loginWithFBBtn = FSLButton(backgroundImage: UIImage(named: "FB"), title: "Log in with Facebook", titleColor: .white, titleHorizontalAlignment: .center)
    let loginWithGoogleBtn = GIDSignInButton(frame: CGRect(x: 0, y:0, width: 230, height: 48))
    //FSLButton(backgroundImage: UIImage(named: "Google"), title: "Log in with Google", titleColor: .black, titleHorizontalAlignment: .center)
    //GIDSignInButton(frame: CGRect(x: 0, y:0, width: 230, height: 48))
    //let signUpBtn = FSLButton(backgroundImage: nil, title: "Create a new account", titleColor: .systemBlue, titleHorizontalAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        //GIDSignIn.sharedInstance().signIn()
        
        //let db = Firestore.firestore()
        
        configure()
        configureScrollView()
        configureHeadView()
        configureTextField()
        configureForgetPassword()
        configureValidationMessage()
        configureButtons()
        
        configureSignInWithThirdPartyMethod()
        configureLines()
        
        createDismissKeyboardTapGesture()
        //configureSigninBtns()
        //confiureSignUpBtn()
    }
    
    // MARK: Private Method
    private func configure() {
        view.backgroundColor = FLColors.FSLbackgroundColor
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.setContentOffset(CGPoint(x: 0, y: 800), animated: true)
        //scrollView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200)
        ])
    }
    
    private func configureHeadView() {
        contentView.addSubview(headView)
        
        NSLayoutConstraint.activate([
            headView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            headView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            headView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        let padding:CGFloat = 14
        
        contentView.addSubviews(emailTextField, passwordTextField)
       
        emailTextField.placeholder = "Email Address"
        passwordTextField.placeholder = "Passwrod"
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: headView.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureForgetPassword() {
        contentView.addSubview(forgetPasswordLabel)
        forgetPasswordLabel.text = "忘记密码?"
        
        NSLayoutConstraint.activate([
            forgetPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            forgetPasswordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            forgetPasswordLabel.heightAnchor.constraint(equalToConstant: 18),
            forgetPasswordLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureValidationMessage() {
        contentView.addSubview(validationMessageLabel)
        validationMessageLabel.text = TestMessages.defaultTestMessage
        validationMessageLabel.textColor = .red
        
        NSLayoutConstraint.activate([
            validationMessageLabel.topAnchor.constraint(equalTo: forgetPasswordLabel.topAnchor),
            validationMessageLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            validationMessageLabel.trailingAnchor.constraint(equalTo: forgetPasswordLabel.leadingAnchor),
            forgetPasswordLabel.heightAnchor.constraint(equalTo: forgetPasswordLabel.heightAnchor)
        ])
    }
    
    private func configureButtons() {
        contentView.addSubviews(signInButton, signUpButton)
        
        signInButton.addTarget(self, action: #selector(signin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(pushSignUpVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: validationMessageLabel.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
                
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            signUpButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureLines() {
        contentView.addSubviews(leftLineView, rightLineView)
        
        NSLayoutConstraint.activate([
            leftLineView.centerYAnchor.constraint(equalTo: thirdPartyLabel.centerYAnchor),
            leftLineView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            leftLineView.trailingAnchor.constraint(equalTo: thirdPartyLabel.leadingAnchor, constant: -5),
            leftLineView.heightAnchor.constraint(equalToConstant: 1),
            
            rightLineView.centerYAnchor.constraint(equalTo: thirdPartyLabel.centerYAnchor),
            rightLineView.leadingAnchor.constraint(equalTo: thirdPartyLabel.trailingAnchor, constant: 5),
            rightLineView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            rightLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func configureSignInWithThirdPartyMethod() {
        contentView.addSubviews(thirdPartyLabel, loginWithGoogleBtn)
        
        thirdPartyLabel.text = "以第三方登录"
        thirdPartyLabel.textColor = .black
        loginWithGoogleBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thirdPartyLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            thirdPartyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140),
            thirdPartyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -140),
            thirdPartyLabel.heightAnchor.constraint(equalToConstant: 18),
            
            loginWithGoogleBtn.topAnchor.constraint(equalTo: thirdPartyLabel.bottomAnchor, constant: 20),
            loginWithGoogleBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            loginWithGoogleBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            loginWithGoogleBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushSignUpVC() {
        
        let signUpVC = SignUpVC()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(signUpVC, animated: false)
    }
    
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
        
        if !passwordTextField.text!.isValidPassword {
            validateMessage += "Password entered is invalid."
            isValid = false
        }
        
        guard isValid else {
            presentFLAlertOnMainThread(title: "Validation Message", message: validateMessage, buttonTitle: "Ok")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongSelf = self else { return }
                print(authResult!.user.uid)
        }
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
}
