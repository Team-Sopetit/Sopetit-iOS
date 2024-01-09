//
//  StoryTellingThirdView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class StoryTellingThirdView: UIView {

    // MARK: - UI Components
    
    private let backgroundView: UIImageView = {
        let back = UIImageView()
        back.image = ImageLiterals.Onboarding.imgSpotlight3
        back.contentMode = .scaleAspectFit
        return back
    }()
    
    private let doorImage: UIImageView = {
        let girl = UIImageView()
        girl.image = ImageLiterals.Onboarding.imgDoor
        girl.contentMode = .scaleAspectFit
        return girl
    }()
    
    private let boxImage: UIImageView = {
        let box = UIImageView()
        box.image = ImageLiterals.Onboarding.imgBoxClosed
        box.contentMode = .scaleAspectFit
        return box
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.thirdButtonTitle, for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.setBackgroundColor(.SoftieWhite, for: .normal)
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

private extension StoryTellingThirdView {
    
    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        nextButton.addSubview(arrowImage)
        addSubviews(doorImage, boxImage, backgroundView, nextButton)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        doorImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 104 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(390)
        }
        
        boxImage.snp.makeConstraints {
            $0.bottom.equalTo(doorImage.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(141)
            $0.height.equalTo(120)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 107 / 812)
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
