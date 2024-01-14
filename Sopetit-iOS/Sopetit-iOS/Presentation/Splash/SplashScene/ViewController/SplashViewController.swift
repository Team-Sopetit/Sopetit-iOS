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
        
        // 스플래시 뷰에서 표시할 내용 추가
        // 예: 배경 이미지, 로고 등
        
        // 일정 시간 후에 다음 화면으로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 2.0초 후에 다음 화면으로 전환
            self.navigateToNextScreen()
        }
    }
    
    private func navigateToNextScreen() {
        let nav = LoginViewController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
}
