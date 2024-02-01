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
        setDelegate()
    }
}

// MARK: - Extensions

extension WithdrawViewController {

    func setUI() {
        self.view.backgroundColor = .SoftieBack
    }
    
    func setDelegate() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
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
        withdrawView.leftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        withdrawView.rightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case withdrawView.leftButton:
            self.navigationController?.popViewController(animated: true)
        case withdrawView.rightButton:
            deleteResignAPI()
        default:
            break
        }
    }
    
    func presentToLoginView() {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            keyWindow.rootViewController = LoginViewController()
        }
    
    func deleteResignAPI() {
        AuthService.shared.deleteResignAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if data is GenericResponse<ResignEntity> {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let keyWindow = windowScene.windows.first else {
                        return
                    }
                    UserManager.shared.clearAll()
                    let nav = LoginViewController()
                    keyWindow.rootViewController = UINavigationController(rootViewController: nav)
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.deleteResignAPI()
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

extension WithdrawViewController {
    func setBarConfiguration() {
        customNaviBar.isBackButtonIncluded = true
        customNaviBar.isTitleViewIncluded = true
        customNaviBar.isTitleLabelIncluded = "회원탈퇴"
        customNaviBar.delegate = self
    }
}

extension WithdrawViewController: BackButtonProtocol {
    
    @objc
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WithdrawViewController: UIGestureRecognizerDelegate {
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackButton))
        view.addGestureRecognizer(tapGesture)
    }
}
