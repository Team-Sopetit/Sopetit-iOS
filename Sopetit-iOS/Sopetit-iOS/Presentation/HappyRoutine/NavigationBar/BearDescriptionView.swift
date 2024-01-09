//
//  bearDescriptionView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class BearDescriptionView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    private let faceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Onboarding.imgFaceBrown
        return imageView
    }()
    
    private let speechImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Onboarding.svgSpeechLong
        return imageView
    }()
    
    private let speechLabel: UILabel = {
        let label = UILabel()
        label.text = "행복루틴은 매일 조금씩 너에 대해\n알아갈 수 있는 특별한 루틴이야!"
        label.font = .fontGuide(.bubble16)
        return label
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

extension BearDescriptionView {

    func setUI() {
        
    }
    
    func setHierarchy() {
        self.addSubviews(faceImageView, speechImageView)
    }
    
    func setLayout() {
        faceImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
        }
        
        speechImageView.snp.makeConstraints {
            $0.leading.equalTo(faceImageView.snp.trailing).offset(14)
            $0.centerY.equalTo(faceImageView.snp.centerY)
        }
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