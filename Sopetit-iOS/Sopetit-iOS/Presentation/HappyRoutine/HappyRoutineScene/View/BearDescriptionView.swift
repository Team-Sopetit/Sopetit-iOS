//
//  bearDescriptionView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class BearDescriptionView: UIView {
    
    // MARK: - UI Components
    
    let faceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let speechImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Onboarding.svgSpeechLong
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let speechLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.HappyRoutine.bearBubble
        label.font = .fontGuide(.bubble16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension BearDescriptionView {
    
    func setHierarchy() {
        self.addSubviews(faceImageView, speechImageView, speechLabel)
    }
    
    func setLayout() {
        faceImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.width.equalTo(53)
            $0.height.equalTo(50)
        }
        
        speechImageView.snp.makeConstraints {
            $0.leading.equalTo(faceImageView.snp.trailing).offset(14)
            $0.centerY.equalTo(faceImageView.snp.centerY)
        }
        
        speechLabel.snp.makeConstraints {
            $0.centerY.equalTo(speechImageView.snp.centerY)
            $0.trailing.equalTo(speechImageView.snp.trailing).offset(-28)
        }
    }
}

extension BearDescriptionView {
    func setDollImage(url: String) {
        faceImageView.kfSetImage(url: url)
    }
}
