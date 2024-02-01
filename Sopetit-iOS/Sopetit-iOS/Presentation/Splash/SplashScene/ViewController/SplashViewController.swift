//
//  SplashViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/14/24.
//

import UIKit

import SnapKit
import FirebaseAnalytics

enum AppstoreOpenError: Error {
    case invalidAppStoreURL
    case cantOpenAppStoreURL
}

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var randomNumber: Int = Int.random(in: (0 ..< splashViews.count))
    private var versionEntity = VersionEntity(iosVersion: Version(appVersion: "", forceUpdateVersion: ""), androidVersion: Version(appVersion: "", forceUpdateVersion: ""), notificationTitle: "", notificationContent: "")
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let appStoreOpenUrlString = "itms-apps://itunes.apple.com/app/apple-store/6476357728"
    
    // MARK: - UI Components
    
    private let splashViews: [UIView] = [SplashOneView(), SplashTwoView(), SplashThreeView(), SplashFourView()]
    private let updateAlertView = UpdateAlertView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        self.view = splashViews[randomNumber]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.getVersionAPI()
        }
    }
}

private extension SplashViewController {
    
    func setUI() {
        Analytics.logEvent("view_splash", parameters: nil)
        
        self.updateAlertView.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        updateAlertView.alertDelegate = self
    }
    
    func setHierarchy() {
        self.view.addSubview(updateAlertView)
    }
    
    func setLayout() {
        updateAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func openAppStore(urlStr: String) -> Result<Void, AppstoreOpenError> {
        guard let url = URL(string: urlStr) else {
            return .failure(.invalidAppStoreURL)
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return .success(())
        } else {
            return .failure(.cantOpenAppStoreURL)
        }
    }
    
    func showUpdateAlert(forceResult: Int, recommendResult: Int) {
        if forceResult < 0 {
            updateAlertView.isHidden = false
            updateAlertView.setDataBind(updateCase: "force", model: self.versionEntity)
        } else if recommendResult < 0 {
            updateAlertView.isHidden = false
            updateAlertView.setDataBind(updateCase: "recommend", model: self.versionEntity)
        } else {
            updateAlertView.isHidden = true
            self.showNextPage()
        }
    }
    
    func showNextPage() {
        if UserManager.shared.hasAccessToken {
            if UserManager.shared.isPostMemeber {
                postLoginAPI(socialAccessToken: UserManager.shared.getAccessToken, socialType: UserManager.shared.getSocialType)
            } else {
                presentToOnboardingView()
            }
        } else {
            presentToLoginView()
        }
    }
    
    func presentToOnboardingView() {
        let nav = StoryTellingViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func presentToLoginView() {
        let nav = LoginViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func presentToHomeView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
    }
}

extension SplashViewController: AlertDelgate {
    
    func forceButtonTapped() {
        let result = self.openAppStore(urlStr: self.appStoreOpenUrlString)
        switch result {
        case .success:
            break
        case .failure(let error):
            print("Failed to open App Store: \(error)")
        }
    }
    
    func recommendBackButtonTapped() {
        self.dismiss(animated: false, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.showNextPage()
            }
        })
    }
    
    func recommendUpdateButtonTapped() {
        let result = self.openAppStore(urlStr: self.appStoreOpenUrlString)
        switch result {
        case .success:
            break
        case .failure(let error):
            print("Failed to open App Store: \(error)")
        }
    }
}

// MARK: - Network

private extension SplashViewController {
    
    func tokenCheck(socialAccessToken: String, socialType: String) {
            AuthService.shared.postLogoutAPI { networkResult in
                switch networkResult {
                case .success:
                    self.presentToHomeView()
                case .reissue:
                    ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                        if success {
                            self.presentToHomeView()
                        } else {
                            self.presentToLoginView()
                        }
                    }
                case .requestErr, .serverErr:
                    break
                default:
                    break
                }
            }
        }
}

private extension SplashViewController {
    func showNextPage() {
        if UserManager.shared.hasAccessToken {
            if UserManager.shared.isPostMemeber {
                tokenCheck(socialAccessToken: UserManager.shared.getAccessToken, socialType: UserManager.shared.getSocialType)
            } else {
                presentToOnboardingView()
    }
    
    func getVersionAPI() {
        AuthService.shared.getVersionAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<VersionEntity> {
                    if let listData = data.data {
                        self.versionEntity = listData
                    }
                    if let comparisonResult = self.appVersion?.compare(self.versionEntity.iosVersion.forceUpdateVersion, options: .numeric).rawValue as? Int, let comparisonResult2 = self.appVersion?.compare(self.versionEntity.iosVersion.appVersion, options: .numeric).rawValue as? Int {
                        self.showUpdateAlert(forceResult: comparisonResult, recommendResult: comparisonResult2)
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func presentToOnboardingView() {
        let nav = StoryTellingViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func presentToLoginView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = LoginViewController()
    }
    
    func presentToHomeView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
    }
}
