//
//  DropoutView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/14/24.
//

import UIKit

import SnapKit

final class WithdrawView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    let headLabel: UILabel = {
        let label = UILabel()
        label.text = "소프티를 정말 탈퇴하시나요?"
        label.textColor = .Gray700
        label.partColorChange(targetString: "탈퇴", textColor: .SoftieRed)
        label.font = .fontGuide(.head1)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하면 계정이 삭제되고 모든 데이터가 사라집니다."
        label.font = .fontGuide(.body4)
        label.textColor = .Gray300
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray100
        button.setTitle("더 써볼래", for: .normal)
        button.setTitleColor(.Gray300, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SoftieRed
        button.setTitle("탈퇴할래", for: .normal)
        button.setTitleColor(.Gray000, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Setting.imgBoxLogout
        return image
    }()
    
    let bubbleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_speech_happy")
        return image
    }()
    
    let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Setting.withdraw
        label.numberOfLines = 2
        label.font = .fontGuide(.bubble18)
        label.textColor = .Gray700
        label.textAlignment = .center
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

extension WithdrawView {

    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(leftButton, rightButton, headLabel, bodyLabel, boxImage, bubbleImage)
        bubbleImage.addSubview(bubbleLabel)
    }
    
    func setLayout() {
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(27)
            $0.trailing.equalTo(self.snp.centerX).inset(5)
            $0.bottom.equalToSuperview().inset(48)
            $0.height.equalTo(58)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(27)
            $0.leading.equalTo(self.snp.centerX).offset(5)
            $0.bottom.equalToSuperview().inset(48)
            $0.height.equalTo(58)
        }
        
        headLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(67)
            $0.centerX.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(headLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        bubbleImage.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(74)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(68)
            $0.width.equalTo(200)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bubbleImage.snp.top).inset(12)
            $0.leading.trailing.equalToSuperview().inset(43)
        }
        
        boxImage.snp.makeConstraints {
            $0.top.equalTo(bubbleImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(208)
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
