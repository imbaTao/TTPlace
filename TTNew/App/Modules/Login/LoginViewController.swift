//
//  LoginViewController.swift
//  GanLiao
//
//  Created by Mr.hong on 2020/11/3.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         登录控制器一般包含什么
         一键登录，
         密码用户名输入框
         三方登录
         短信验证登录
         隐私政策网址
         */
        
        
//        let appleButton = TTButton.init(text: "apple登录", textColor: .black, font: .medium(20), iconImage: nil, type: .justText, intervalBetweenIconAndText: 10, padding: .zero)
//        appleButton.backgroundColor = .red
//        addSubview(appleButton)
//        appleButton.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
//
//        // 苹果登录
//        appleButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let auth = ASAuthorizationController(authorizationRequests: [request])
//            auth.delegate = self
//            auth.presentationContextProvider = self
//            auth.performRequests()
//        }).disposed(by: rx.disposeBag)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    @objc func injected() {

    }
    
    // ios 13 apple登录代理
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return rootWindow()
    }
    
    
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
       let credential: ASAuthorizationAppleIDCredential = authorization.credential as! ASAuthorizationAppleIDCredential
        
        print(credential)
//            ACCOUNT.appleUserUUID = credential.user
//            ACCOUNT.isLogin = true
//            USER.gender = "1"
//            updateAccountInfo()
//            loginSuccess()
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 苹果登录失败
        
//        USER.appleUserUUID = credential.user
//        ACCOUNT.isLogin = true
//        USER.gender = "1"
//        updateAccountInfo()
//        loginSuccess()
    }
}



