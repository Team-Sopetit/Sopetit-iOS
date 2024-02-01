//
//  SplashViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/14/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var randomNumber: Int = Int.random(in: (0 ..< splashViews.count))
    
    // MARK: - UI Components
    
    private let splashViews: [UIView] = [SplashOneView(), SplashTwoView(), SplashThreeView(), SplashFourView()]
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = splashViews[randomNumber]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.showNextPage()
        }
    }
}

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
