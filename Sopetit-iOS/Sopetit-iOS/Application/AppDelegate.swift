//
//  AppDelegate.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/28.
//

import UIKit

import KakaoSDKCommon
import AuthenticationServices
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String
        
        KakaoSDK.initSDK(appKey: apiKey!)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: UserManager.shared.appleUserIdentifier ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
            case .revoked:
                print("revoked")
                UserManager.shared.clearAll()
            default:
                print("notFound")
            }
        }
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
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
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: UserManager.shared.appleUserIdentifier ?? "") { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("authorized")
                case .revoked:
                    print("revoked")
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let keyWindow = windowScene.windows.first else {
                        return
                    }
                    UserManager.shared.clearAll()
                    let nav = LoginViewController()
                    keyWindow.rootViewController = UINavigationController(rootViewController: nav)
                default:
                    print("notFound")
                }
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let applicationState = UIApplication.shared.applicationState
        if applicationState == .active || applicationState == .inactive || applicationState == .background {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            let tabVC = TabBarController()
            keyWindow.rootViewController = UINavigationController(rootViewController: tabVC)
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken =  fcmToken else { return }
        print("✅✅✅fcmToken✅✅✅")
        print(fcmToken)
        print("✅✅✅fcmToken✅✅✅")
        UserManager.shared.updateFcmToken(fcmToken)
    }
}
