//
//  AppDelegate.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/28.
//

import UIKit

import KakaoSDKCommon
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String
        
        KakaoSDK.initSDK(appKey: apiKey!)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "00000.abcabcabcabc.0000(로그인에 사용한 UserIdentifier)") { (credentialState, error) in
            switch credentialState {
            case .authorized: // 이미 증명이 된 경우 (정상)
                print("authorized")
                // The Apple ID credential is valid.
            case .revoked:    // 증명을 취소했을 때,
                print("revoked")
                // 로그인뷰로 이동하기
            case .notFound:   // 증명이 존재하지 않을 경우
                print("notFound")
                // 로그인뷰로 이동하기
            default:
                break
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
