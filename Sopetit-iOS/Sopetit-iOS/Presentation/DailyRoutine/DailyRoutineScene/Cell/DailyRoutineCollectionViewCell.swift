//
//  RoutineCollectionViewCell.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit
import SnapKit

final class RoutineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.DailyRoutine.icDaily1Filled
        return image
    }()
    
    let flagImg: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.DailyRoutine.icFlag
        return image
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray300
        return label
    }()
    
    lazy var routineLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray700
        return label
    }()
    
    lazy var achieveButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body4)
        button.backgroundColor = .SoftieMain1
        button.layer.cornerRadius = 10 // 테두리를 둥글게 만들기 위한 코너 반지름 설정
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func onTapButton(sender: UIButton) {
        print("Button was tapped.")
        
        if sender.isSelected {
            sender.isSelected = false
            sender.setTitle("완료하기", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.backgroundColor = UIColor.SoftieMain1
        } else {
            sender.isSelected = true
            sender.setTitle("달성 완료", for: .normal)
            sender.setTitleColor(UIColor.Gray300, for: .normal)
            sender.backgroundColor = UIColor.Gray100
        }
    }
    
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

extension RoutineCollectionViewCell {

    func setUI() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .white
    }
    
    func setHierarchy() {
        self.addSubviews(imageView, dateLabel, routineLabel, achieveButton, flagImg)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(22)
            $0.size.equalTo(40)
        }
        flagImg.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(flagImg.snp.trailing).offset(4)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        routineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(flagImg)
        }
        achieveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }
    }
    
    func setDatabind(model: DailyEntity) {
        self.dateLabel.text = "\(model.dateLabel)일 달성 중"
        self.routineLabel.text = model.routineLabel
    }
}
