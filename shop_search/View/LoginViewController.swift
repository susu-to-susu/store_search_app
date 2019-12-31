//
//  Login.swift
//  shop_search
//
//  Created by susu on 2019/12/30.
//  Copyright © 2019 susu. All rights reserved.
//

import UIKit
import AuthenticationServices

// @availableでiOS12以前で実行する場合、iOS13以降の処理は無効化
@available(iOS 13.0, *)
class LoginViewController: BaseController {
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // iOS12以前でテストする場合はコメントアウト
        performExistingAccountSetupFlows()
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // ボタン押下時
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        // ASAuthorizationAppleIDRequestの作成
        let request = ASAuthorizationAppleIDProvider().createRequest()
        // Scopeの設定
        request.requestedScopes = [.email, .fullName]

        // ASAuthorizationControllerの作成
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        // Delegateの設定
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        // 認証リクエストを実行
        authorizationController.performRequests()
        print("handleAuthorizationAppleIDButtonPress()")
    }
    
    // 仮button(実機テスト用)
    // 手元のiPhone6がiOS13非対応であるため
    @IBAction func loginButton(_ sender: Any) {
        // ログイン無しで、次画面遷移(Sign In with Appleを利用しない場合)
        self.performSegue(withIdentifier: "searchViewController", sender: nil)
    }

}

// @availableでiOS12以前で実行する場合、iOS13以降の処理は無効化
@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 文字他でも使う場合はコメントを外す
            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
            
            // Create an account in your system.
            // For the purpose of this demo app, store the userIdentifier in the keychain.
            do {
                try KeychainItem(service: "susu.com.shop-search", account: "userIdentifier").saveItem(userIdentifier)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
            
            // For the purpose of this demo app, show the Apple ID credential information in the SearchViewController.
            if (self.presentingViewController as? SearchViewController) != nil {
                DispatchQueue.main.async {
                    // 認証の小画面を閉じる
                    self.dismiss(animated: true, completion: nil)
                }
            }
            // 画面遷移
            self.performSegue(withIdentifier: "searchViewController", sender: nil)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

// @availableでiOS12以前で実行する場合、iOS13以降の処理は無効化
@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


