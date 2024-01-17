//
//  HappyRoutineCategoryCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/10/24.
//

import UIKit

import SnapKit

final class HappyRoutineCategoryCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        return label
    }()
    
    private let nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.icNext
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - Extensions

private extension HappyRoutineCategoryCollectionViewCell {
    
    func setUI() {
        contentView.backgroundColor = .SoftieWhite
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.Gray100.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func setHierarchy() {
        self.addSubviews(imageView, titleLabel, contentLabel, nextImageView)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(57)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalTo(nextImageView.snp.leading).offset(13)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(imageView.snp.trailing).offset(13)
            $0.trailing.equalTo(nextImageView.snp.leading).offset(-13)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
    }
}

extension HappyRoutineCategoryCollectionViewCell {
    
    func setDataBind(model: Happiness) {
        imageView.kfSetImage(url: model.iconImageUrl)
        titleLabel.text = model.name
        titleLabel.textColor = UIColor(hex: model.nameColor)
        contentLabel.text = model.title
    }
}
