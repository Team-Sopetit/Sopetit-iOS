//
//  SettingTableViewCell.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/12/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    static let isFromNib: Bool = false    
    static let identifier: String = "SettingTableViewCell"

    // MARK: - UI Components
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray600
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_setting_right"), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

extension SettingTableViewCell {

    func setUI() {
        self.backgroundColor = .SoftieWhite
    }
    
    func setHierarchy() {
        self.addSubviews(iconImage, settingLabel, nextButton)
    }
    
    func setLayout() {
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(19)
        }
        
        settingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImage.snp.trailing).offset(8)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(23)
        }
    }
}
