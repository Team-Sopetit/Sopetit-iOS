//
//  ThemeSelectCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class ThemeSelectCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 9
        stackview.alignment = .center
        return stackview
    }()
    
    var themeIcon: UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = .SoftieWhite
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 35
        icon.layer.borderColor = UIColor.Gray100.cgColor
        icon.layer.borderWidth = 1
        icon.contentMode = .scaleAspectFit
        icon.contentMode = .center
        return icon
    }()
    
    private let themeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .Gray400
        label.textAlignment = .center
        label.font = .fontGuide(.caption1)
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

extension ThemeSelectCollectionViewCell {
    
    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        stackview.addArrangedSubviews(themeIcon, themeTitle)
        self.addSubview(stackview)
    }
    
    func setLayout() {
        themeIcon.snp.makeConstraints {
            $0.size.equalTo(70)
        }
        
        stackview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setDataBind(model: Theme) {
        themeTitle.text = model.name
        themeIcon.kfSetImage(url: model.iconImageURL)
    }
}
