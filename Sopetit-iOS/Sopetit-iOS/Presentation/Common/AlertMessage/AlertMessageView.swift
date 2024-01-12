//
//  AlertMessageView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/12.
//

import UIKit

import SnapKit

final class AlertMessageView: UIView {
    
    // MARK: - UI Components
    
    private var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray300
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let checkImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.DailyRoutine.icCheck
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제함"
        label.textAlignment = .left
        label.textColor = .SoftieWhite
        label.font = .fontGuide(.body3)
        return label
    }()
    
    // MARK: - Life Cycles
    
    init(title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
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

extension AlertMessageView {
    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        alertView.addSubviews(checkImage, titleLabel)
        addSubview(alertView)
    }
    
    func setLayout() {
        checkImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
            $0.size.equalTo(17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkImage.snp.trailing).offset(4)
        }
        
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
