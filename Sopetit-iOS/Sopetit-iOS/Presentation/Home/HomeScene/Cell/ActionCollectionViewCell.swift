//
//  ActionCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/10/24.
//

import UIKit

import SnapKit

final class ActionCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = SizeLiterals.Screen.screenWidth * 4 / 375
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = UIColor.Gray300
        return label
    }()
    
    private let actionLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = UIColor.Gray500
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

extension ActionCollectionViewCell {

    func setUI() {
        backgroundColor = UIColor.Gray000
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
    }
    
    func setHierarchy() {
        addSubviews(stackView, actionLabel)
        
        stackView.addArrangedSubviews(iconImageView, numberLabel)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(13)
        }

        iconImageView.snp.makeConstraints {
            $0.size.equalTo(28)
        }
        
        actionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(13)
        }
    }
    
    func setDataBind(model: HomeEntity) {
        switch tag {
        case 0:
            actionLabel.text = I18N.Home.actionTitle1
            numberLabel.text = "\(model.dailyCottonCount)개"
            iconImageView.image = ImageLiterals.Home.icSomWhite
        case 1:
            actionLabel.text = I18N.Home.actionTitle2
            numberLabel.text = "\(model.happinessCottonCount)개"
            iconImageView.image = ImageLiterals.Home.icSomColor
        default:
            break
        }
    }
}
