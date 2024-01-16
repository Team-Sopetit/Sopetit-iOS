//
//  StoryTellingFirstView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class StoryTellingFirstView: UIView {
    
    // MARK: - UI Components
    
    private let backgroundView: UIImageView = {
        let back = UIImageView()
        back.image = ImageLiterals.Onboarding.imgSpotlight1
        back.contentMode = .scaleAspectFill
        return back
    }()
    
    private let girlImage: UIImageView = {
        let girl = UIImageView()
        girl.image = ImageLiterals.Onboarding.imgGirl1
        girl.contentMode = .scaleAspectFit
        return girl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.firtButtonTitle, for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.setBackgroundColor(.SoftieWhite, for: .normal)
        button.setBackgroundColor(.SoftieWhite, for: .highlighted)
        button.titleLabel?.font = .fontGuide(.bubble20)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = ImageLiterals.Onboarding.icOnboardNext
        arrow.contentMode = .scaleAspectFit
        return arrow
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

private extension StoryTellingFirstView {

    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        nextButton.addSubview(arrowImage)
        addSubviews(girlImage, backgroundView, nextButton)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        girlImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 218 / 812)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(210)
            $0.height.equalTo(360)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 73 / 812)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(64)
        }
        
        arrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(23)
            $0.size.equalTo(14)
        }
    }
}
