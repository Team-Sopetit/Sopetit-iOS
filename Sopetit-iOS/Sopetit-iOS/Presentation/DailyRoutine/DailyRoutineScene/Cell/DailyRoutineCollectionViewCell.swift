//
//  RoutineCollectionViewCell.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit

import SnapKit

final class DailyRoutineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    weak var delegate: PresentDelegate?
    var status = 0
    static var sharedVariable: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("SharedVariableDidChange"), object: nil)
        }
    }

    // MARK: - UI Components
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.DailyRoutine.icDaily1Filled
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let flagImg: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.DailyRoutine.icFlag
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray300
        return label
    }()
    
    let routineLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray700
        label.numberOfLines = 0
        return label
    }()
    
    lazy var achieveButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.DailyRoutine.complete, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.body4)
        button.setBackgroundColor(.SoftieMain1, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle(I18N.DailyRoutine.completed, for: .disabled)
        button.setTitleColor(.Gray300, for: .disabled)
        button.setBackgroundColor(.Gray100, for: .disabled)
        return button
    }()
    
    lazy var checkBox: UIButton = {
        let view = UIButton()
        view.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)
        view.setImage(ImageLiterals.DailyRoutine.btnRadiobtnSelected, for: .selected)
        view.isHidden = true
        return view
    }()
    
    let labelBox: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DailyRoutineCollectionViewCell {

    func setUI() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray100.cgColor
        self.backgroundColor = .white
    }
    
    func setHierarchy() {
        self.addSubviews(imageView, achieveButton, checkBox, labelBox)
        labelBox.addSubviews(flagImg, dateLabel, routineLabel)
    }
    
    func setLayout() {
        
        labelBox.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(23)
            $0.bottom.equalTo(achieveButton.snp.top).offset(-20)
            $0.trailing.equalToSuperview().inset(52)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(40)
            $0.centerY.equalTo(labelBox.snp.centerY)
        }
        
        flagImg.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(routineLabel.snp.bottom).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(flagImg.snp.trailing).offset(4)
            $0.top.equalTo(routineLabel.snp.bottom).offset(8)
        }
        
        routineLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(flagImg)
        }
        
        achieveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(23)
            $0.height.equalTo(38)
        }
        
        checkBox.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
                
    }
    
    func setDatabind(model: Routine1) {
        self.dateLabel.text = "\(model.achieveCount)일 달성 중"
        self.routineLabel.text = model.content
        if let iconURL = URL(string: model.iconImageURL) {
            self.imageView.downloadedsvg(from: iconURL)
        }
    }
    
    func setAddTarget() {
        self.achieveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.checkBox.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case achieveButton:
            if sender.isSelected {
                sender.isSelected = false
            } else {
                delegate?.buttonTapped(in: self)
                if status == 1 {
                    sender.isSelected = true
                }
            }
        case checkBox:
            if sender.isSelected {
                DailyRoutineCollectionViewCell.sharedVariable-=1
            } else {
                DailyRoutineCollectionViewCell.sharedVariable+=1
            }
            sender.isSelected = !sender.isSelected
        default:
            break
        }
    }
    
}
