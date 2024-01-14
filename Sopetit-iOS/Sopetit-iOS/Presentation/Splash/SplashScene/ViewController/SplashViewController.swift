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
            self.navigateToNextScreen()
        }
    }
    
    private func navigateToNextScreen() {
        let nav = LoginViewController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
}
