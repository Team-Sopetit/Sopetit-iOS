//
//  LoginView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/7/24.
//

import UIKit

import SnapKit

final class LoginView: UIView {
    
    // MARK: - Properties
    
    private let softieLabel: UILabel = {
        let label = UILabel()
        label.text = "softie"
        label.font = .fontGuide(.body1)
        return label
    }()
    
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(systemName: "apple.logo")
         return imageView
    }()
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(systemName: "apple.logo")
         return imageView
    }()
    
    private let kakaoLoginButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let kakaoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "apple.logo")
        return imageView
    }()
    
    private let kakaoLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오로 시작하기"
        label.textColor = .black
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let appleLoginButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let appleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "apple.logo")
        return imageView
    }()
    
    private let appleLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple로 시작하기"
        label.textColor = .black
        label.font = .fontGuide(.body2)
        return label
    }()
    
    // MARK: - UI Components
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
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
        self.addSubviews(softieLabel, bubbleImageView, boxImageView, kakaoLoginButtonView, appleLoginButtonView)
        kakaoLoginButtonView.addSubviews(kakaoImageView, kakaoLoginLabel)
        appleLoginButtonView.addSubviews(appleImageView, appleLoginLabel)
    }
    
    func setLayout() {
        softieLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(187)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(boxImageView.snp.top).offset(-10)
        }
        
        boxImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(kakaoLoginButtonView.snp.top).offset(-44)
        }
        
        kakaoLoginButtonView.snp.makeConstraints {
            $0.leading.trailing.equalTo(appleLoginButtonView)
            $0.bottom.equalTo(appleLoginButtonView.snp.top).offset(-16)
            $0.height.equalTo(45)
        }
        
        kakaoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(18)
        }
        
        kakaoLoginLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        appleLoginButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(75)
            $0.height.equalTo(45)
        }
        
        appleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(18)
        }
        
        appleLoginLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setGestureRecognizers() {
        let kakaoLogintapGesture = UITapGestureRecognizer(target: self, action: #selector(kakaoLoginButtonTapped(_:)))
        kakaoLoginButtonView.addGestureRecognizer(kakaoLogintapGesture)
        
        let appleLogintapGesture = UITapGestureRecognizer(target: self, action: #selector(appleLoginButtonTapped(_:)))
        appleLoginButtonView.addGestureRecognizer(appleLogintapGesture)
    }
    
    func setAddTarget() {
        
    }
    
    @objc
    func buttonTapped() {
        
    }
    
    @objc
    func kakaoLoginButtonTapped(_ sender: UITapGestureRecognizer) {
        print("카카오 로그인 버튼 탭함.")
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String else { return }
        print(apiKey)
    }
    
    @objc
    func appleLoginButtonTapped(_ sender: UITapGestureRecognizer) {
        print("애플 로그인 버튼 탭함.")
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}
