//
//  AlarmViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 11/11/24.
//

import UIKit

import SnapKit

final class AlarmViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let customNaviBar: CustomNavigationBarView = {
        let navigationBar = CustomNavigationBarView()
        navigationBar.isBackButtonIncluded = true
        navigationBar.isTitleViewIncluded = true
        navigationBar.isTitleLabelIncluded = "알림"
        return navigationBar
    }()
    
    private let alarmTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴 알림"
        label.textColor = .Gray700
        label.font = .fontGuide(.body1)
        label.asLineHeight(.body1)
        return label
    }()
    
    private let alarmSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴을 까먹지 않도록 알려드릴게요"
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private lazy var alarmSwitch: UISwitch = {
        let swicth: UISwitch = UISwitch()
        swicth.isOn = UserManager.shared.hasAllowAlarm
        return swicth
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension AlarmViewController {
    
    func setUI() {
        view.backgroundColor = .SoftieWhite
        customNaviBar.backgroundColor = .SoftieWhite
    }
    
    func setDelegate() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        customNaviBar.delegate = self
    }
    
    func setHierarchy() {
        self.view.addSubviews(customNaviBar,
                              alarmTitleLabel,
                              alarmSubTitleLabel,
                              alarmSwitch)
    }
    
    func setLayout() {
        customNaviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        alarmTitleLabel.snp.makeConstraints {
            $0.top.equalTo(customNaviBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        alarmSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(alarmTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(alarmTitleLabel.snp.leading)
        }
        
        alarmSwitch.snp.makeConstraints {
            $0.top.equalTo(customNaviBar.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(51)
            $0.height.equalTo(31)
        }
    }
}

extension AlarmViewController: BackButtonProtocol {
    
    @objc
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
