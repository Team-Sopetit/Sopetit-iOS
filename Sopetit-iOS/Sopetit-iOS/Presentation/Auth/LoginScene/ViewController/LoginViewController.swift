//
//  LoginViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/7/24.
//

import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var kakaoEntity: LoginEntity?
    private var appleEntity: LoginEntity?
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension LoginViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        loginView.loginDelegate = self
    }
}

// MARK: - Network

extension LoginViewController {
    func postLoginAPI(socialAccessToken: String, socialType: String) {
        AuthService.shared.postLoginAPI(socialAccessToken: socialAccessToken, socialType: socialType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<LoginEntity> {
                    switch socialType {
                    case "KAKAO":
                        if let kakaoData = data.data {
                            self.kakaoEntity = kakaoData
                            self.checkKakaoUser()
                            let nav = StoryTellingViewController()
                            self.navigationController?.pushViewController(nav, animated: true)
                        }
                    case "APPLE":
                        if let appleData = data.data {
                            self.appleEntity = appleData
                            self.checkAppleUser()
                            let nav = StoryTellingViewController()
                            self.navigationController?.pushViewController(nav, animated: true)
                        }
                    default:
                        break
                    }
                }
            case .requestErr, .serverErr:
                print("Error 발생")
            default:
                break
            }
        }
    }
}

extension LoginViewController: LoginDelegate {
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.postLoginAPI(socialAccessToken: accessToken, socialType: "KAKAO")
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.postLoginAPI(socialAccessToken: accessToken, socialType: "KAKAO")
                    }
                }
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("카카오 로그인 실패")
    }
    
    func checkKakaoUser() {
        guard let kakaoEntity = kakaoEntity else { return }
        UserManager.shared.updateToken(kakaoEntity.accessToken, kakaoEntity.refreshToken)
    }
    
    func appleLogin() {
        print("애플 로그인 버튼 탭함.")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    func checkAppleUser() {
        guard let appleEntity = appleEntity else { return }
        UserManager.shared.updateToken(appleEntity.accessToken, appleEntity.refreshToken)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let identityToken = appleIDCredential.identityToken
            if let tokenString = String(data: identityToken!, encoding: .utf8) {
                postLoginAPI(socialAccessToken: tokenString, socialType: "APPLE")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login failed with error: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return  self.view.window!
    }
}
