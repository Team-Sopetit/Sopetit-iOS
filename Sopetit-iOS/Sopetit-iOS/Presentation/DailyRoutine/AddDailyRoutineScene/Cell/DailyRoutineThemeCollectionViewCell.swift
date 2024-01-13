//
//  DailyRoutineThemeCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

import SnapKit

final class DailyRoutineThemeCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        view.layer.borderColor = UIColor.Gray100.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray700
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DailyRoutineThemeCollectionViewCell {

    func setUI() {
        
    }
    
    func setHierarchy() {
        self.addSubviews(containerView, titleLabel)
        containerView.addSubview(iconImageView)
    }
    
    func setLayout() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func setSelected() {
        
    }
}

extension DailyRoutineThemeCollectionViewCell {
    
    func setDataBind(model: DailyRoutineTheme) {
        iconImageView.image = model.iconImage
        titleLabel.text = model.name
        titleLabel.textAlignment = .center
    }
}
