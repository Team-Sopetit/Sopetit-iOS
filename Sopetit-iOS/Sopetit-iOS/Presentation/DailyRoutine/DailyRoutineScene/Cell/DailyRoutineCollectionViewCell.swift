//
//  DailyRoutineCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

import SnapKit

final class DailyRoutineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    var index: Int = 0
    
    // MARK: - UI Components
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray700
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.icFlag
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let achieveLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption2)
        label.textColor = .Gray300
        return label
    }()
    
    private let radioButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)
        return button
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료하기", for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.backgroundColor = .SoftieMain1
        button.layer.cornerRadius = 10
        return button
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

extension DailyRoutineCollectionViewCell {

    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
}

extension DailyRoutineCollectionViewCell {
    
    func setDataBind(model: DailyRoutines) {
        let imageUrl = model.iconImageURL
        iconImageView.kfSetImage(url: imageUrl)
        titleLabel.text = model.content
        achieveLabel.text = "\(model.achieveCount)번째 달성 중"
    }
}
