//
//  HappyRoutineTagCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class HappyRoutineTagCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                bindSelected()
            } else {
                bindNotSelected()
            }
        }
    }
    
    // MARK: - UI Components
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = .Gray400
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagLabel.text = nil
        bindNotSelected()
    }
}

// MARK: - Extensions

private extension HappyRoutineTagCollectionViewCell {
    
    func setUI() {
        contentView.backgroundColor = .SoftieWhite
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 37/2
        contentView.layer.borderColor = UIColor.Gray100.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func setHierarchy() {
        self.addSubviews(tagLabel)
    }
    
    func setLayout() {
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HappyRoutineTagCollectionViewCell {
    
    func bindText(text: String) {
        tagLabel.text = text
    }
    
    func bindSelected() {
        contentView.backgroundColor = .SoftieMain1
        contentView.layer.borderColor = UIColor.SoftieMain1.cgColor
        tagLabel.textColor = .SoftieWhite
    }
    
    func bindNotSelected() {
        contentView.backgroundColor = .SoftieWhite
        contentView.layer.borderColor = UIColor.Gray100.cgColor
        tagLabel.textColor = .Gray400
    }
}
