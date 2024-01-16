//
//  LoginView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/7/24.
//

import UIKit

import SnapKit

protocol LoginDelegate: AnyObject {
    func kakaoLogin()
    func appleLogin()
}

final class LoginView: UIView {
    
    // MARK: - Properties
        
        weak var loginDelegate: LoginDelegate?
    
    // MARK: - UI Components
    
    private let softieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Login.icLogoLogin
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Login.imgSpeechDark
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Login.bubbleTitle
        label.textColor = .Gray100
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Onboarding.bearBrownDown
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let kakaoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Login.icKakao
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let kakaoLoginLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Login.kakaoLoginTitle
        label.textColor = .black
        label.font = .fontGuide(.body2)
        label.backgroundColor = .SoftieYellow
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let appleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Login.icApple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let appleLoginLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Login.appleLoginTitle
        label.textColor = .black
        label.font = .fontGuide(.body2)
        label.backgroundColor = .SoftieWhite
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setGestureRecognizers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension LoginView {
    
    func setUI() {
        backgroundColor = .SoftieWhite
    }
    
    func setHierarchy() {
        self.addSubviews(softieImageView, bubbleImageView, boxImageView, kakaoLoginLabel, kakaoImageView, appleLoginLabel, appleImageView)
        bubbleImageView.addSubview(bubbleLabel)
    }
    
    func setLayout() {
        softieImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 187 / 812)
            $0.width.equalTo(173)
            $0.height.equalTo(52)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(boxImageView.snp.top)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        boxImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(kakaoLoginLabel.snp.top).offset(-44)
        }
        
        kakaoLoginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(appleLoginLabel.snp.top).offset(-16)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 333 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 45 / 812)
        }
        
        kakaoImageView.snp.makeConstraints {
            $0.centerY.equalTo(kakaoLoginLabel)
            $0.leading.equalTo(kakaoLoginLabel.snp.leading).offset(22)
            $0.size.equalTo(18)
        }
        
        appleLoginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(75)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 333 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 45 / 812)
        }
        
        appleImageView.snp.makeConstraints {
            $0.centerY.equalTo(appleLoginLabel)
            $0.leading.equalTo(appleLoginLabel.snp.leading).offset(22)
            $0.width.equalTo(20)
            $0.height.equalTo(22)
        }
    }
    
    func setGestureRecognizers() {
        let kakaoLogintapGesture = UITapGestureRecognizer(target: self, action: #selector(kakaoLoginButtonTapped(_:)))
        kakaoLoginLabel.addGestureRecognizer(kakaoLogintapGesture)
        
        let appleLogintapGesture = UITapGestureRecognizer(target: self, action: #selector(appleLoginButtonTapped(_:)))
        appleLoginLabel.addGestureRecognizer(appleLogintapGesture)
    }
    
    @objc
    func kakaoLoginButtonTapped(_ sender: UITapGestureRecognizer) {
        loginDelegate?.kakaoLogin()
    }
    
    @objc
    func appleLoginButtonTapped(_ sender: UITapGestureRecognizer) {
        loginDelegate?.appleLogin()
    }
}
