//
//  DropoutViewController.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/12/24.
//

import UIKit

import SnapKit

final class WithdrawViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    let customNaviBar = CustomNavigationBarView()
    let withdrawView = WithdrawView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setBarConfiguration()
        setAddTarget()
    }
}

// MARK: - Extensions

extension WithdrawViewController {

    func setUI() {
        self.view.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.view.addSubviews(withdrawView, customNaviBar)
    }
    
    func setLayout() {
        customNaviBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        withdrawView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(customNaviBar.snp.bottom)
        }
    }
    
    func setAddTarget() {
        withdrawView.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func rightButtonTapped() {
        deleteResignAPI()
    }
    
    func deleteResignAPI() {
        AuthService.shared.deleteResignAPI() { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ResignEntity> {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let keyWindow = windowScene.windows.first else {
                        return
                    }
                    UserManager.shared.resign()
                    let nav = SplashViewController()
                    keyWindow.rootViewController = UINavigationController(rootViewController: nav)
                }
            case .requestErr, .serverErr:
                print("Error 발생")
            default:
                break
            }
        }
    }
    
}

extension WithdrawViewController {
    func setBarConfiguration() {
        self.customNaviBar.isBackButtonIncluded = true
        self.customNaviBar.isTitleViewIncluded = true
        self.customNaviBar.isTitleLabelIncluded = "회원탈퇴"
        self.customNaviBar.backButton.addTarget(self, action: #selector(backbuttonTapped), for: .touchUpInside)
    }
    
    @objc
    func backbuttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
