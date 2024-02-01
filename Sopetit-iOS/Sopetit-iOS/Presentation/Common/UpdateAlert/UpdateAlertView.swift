//
//  UpdateAlertView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 1/31/24.
//

import UIKit

import SnapKit

protocol AlertDelgate: AnyObject {
    func forceButtonTapped()
    func recommendBackButtonTapped()
    func recommendUpdateButtonTapped()
}

final class UpdateAlertView: UIView {
    
    // MARK: - Properties
    
    weak var alertDelegate: AlertDelgate?

    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray600
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = .Gray500
        label.numberOfLines = 0
        return label
    }()
    
    lazy var forceUpdateButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.UpdateAlert.forceUpdateButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.SoftieBlue, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var recommendUpdateButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.UpdateAlert.recommendUpdateButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.SoftieBlue, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var recommendBackButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.UpdateAlert.recommendBackButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.Gray100, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension UpdateAlertView {
    
    func setHierarchy() {
        alertView.addSubviews(titleLabel, subTitleLabel, forceUpdateButton, recommendBackButton, recommendUpdateButton)
        self.addSubviews(backgroundView, alertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 291 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 266 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 175 / 812)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.bottom.equalTo(forceUpdateButton.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        forceUpdateButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 245 / 375)
            $0.height.equalTo(49)
        }
        
        recommendBackButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(11)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 118 / 375)
            $0.height.equalTo(49)
        }
        
        recommendUpdateButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(11)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 118 / 375)
            $0.height.equalTo(49)
        }
    }
    
    func setAddTarget() {
        forceUpdateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        recommendBackButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        recommendUpdateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case forceUpdateButton:
            alertDelegate?.forceButtonTapped()
        case recommendBackButton:
            alertDelegate?.recommendBackButtonTapped()
        case recommendUpdateButton:
            alertDelegate?.recommendUpdateButtonTapped()
        default:
            break
        }
    }
    
    func setDataBind(updateCase: String, model: VersionEntity) {
        titleLabel.text = model.notificationTitle
        subTitleLabel.text = model.notificationContent
        subTitleLabel.setLineSpacing(lineSpacing: 2)
        subTitleLabel.textAlignment = .center
        
        switch updateCase {
        case "force":
            forceUpdateButton.isHidden = false
            recommendBackButton.isHidden = true
            recommendUpdateButton.isHidden = true
        case "recommend":
            forceUpdateButton.isHidden = true
            recommendBackButton.isHidden = false
            recommendUpdateButton.isHidden = false
        default:
            break
        }
    }
}
