//
//  SplashTwoView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/13/24.
//

import UIKit

import SnapKit

final class SplashTwoView: UIView {
    
    // MARK: - UI Components
    
    private let softieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Splash.icLogoSplash1
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let mentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray400
        label.font = .fontGuide(.body2)
        label.text = I18N.Splash.mentTitle
        return label
    }()
    
    private let dollImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Splash.imgSplashManybearCut
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension SplashTwoView {
    
    func setUI() {
        backgroundColor = UIColor.SoftieMain2
    }
    
    func setHierarchy() {
        addSubviews(softieImageView, mentLabel, dollImageView)
    }
    
    func setLayout() {
        softieImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(143)
        }
        
        mentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(softieImageView.snp.bottom).offset(11)
        }
        
        dollImageView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 236 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 420 / 812)
        }
    }
}
