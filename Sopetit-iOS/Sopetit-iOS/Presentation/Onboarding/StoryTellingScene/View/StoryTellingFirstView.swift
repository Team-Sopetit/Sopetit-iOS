//
//  StoryTellingFirstView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class StoryTellingFirstView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let backgroundView: UIImageView = {
        let back = UIImageView()
        back.image = ImageLiterals.Onboarding.imgSpotlight1
        back.contentMode = .scaleAspectFit
        return back
    }()
    
    private let girlImage: UIImageView = {
        let girl = UIImageView()
        girl.image = ImageLiterals.Onboarding.imgGirl1
        girl.contentMode = .scaleAspectFit
        return girl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("오늘도 고된 하루였어..", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.setBackgroundColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.bubble20)
        return button
    }()
    
    private let arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = ImageLiterals.Onboarding.icOnboardNext
        
        return arrow
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension StoryTellingFirstView {

    func setUI() {
        
    }
    
    func setHierarchy() {

    }
    
    func setLayout() {

    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}
