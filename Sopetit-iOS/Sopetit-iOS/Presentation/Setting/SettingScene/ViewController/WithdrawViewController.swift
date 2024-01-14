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
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setBarConfiguration()
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
    
    func setDelegate() {
        
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
