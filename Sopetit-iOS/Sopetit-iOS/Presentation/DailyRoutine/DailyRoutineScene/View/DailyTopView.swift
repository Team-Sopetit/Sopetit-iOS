//
//  DailyTopViewView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/9/24.
//

import UIKit

import SnapKit

final class DailyTopView: UIView {

    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "데일리 루틴"
        label.textColor = .black
        return label
    }()
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        return button
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

extension DailyTopView {

    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(titleLabel, editButton)
    }
    
    func setLayout() {
        self.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview().inset(20)
        }
        editButton.snp.makeConstraints() {
            $0.trailing.equalToSuperview().inset(20)
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
