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
        image.contentMode = .scaleAspectFill
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
        return label
    }()
    
    lazy var achieveButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body4)
        button.setBackgroundColor(UIColor.SoftieMain1, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("달성 완료", for: .disabled)
        button.setTitleColor(UIColor.Gray300, for: .disabled)
        button.setBackgroundColor(UIColor.Gray100, for: .disabled)
        return button
    }()
    
    lazy var checkBox: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "btn_radiobtn_none"), for: .normal)
        view.setImage(UIImage(named: "btn_radiobtn_selected"), for: .selected)
        view.isHidden = true
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
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .white
    }
    
    func setHierarchy() {
        self.addSubviews(imageView, dateLabel, routineLabel, achieveButton, flagImg, checkBox)
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
        
        checkBox.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
        
    }
    
    func setDatabind(model: DailyEntity) {
        self.dateLabel.text = "\(model.dateLabel)일 달성 중"
        self.routineLabel.text = model.routineLabel
    }
    
    func setAddTarget() {
        self.achieveButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        self.checkBox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    @objc
    func onTapButton(sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            delegate?.buttonTapped(in: self)
            if status == 1 {
                sender.isSelected = true
            }
        }
    }
    
    @objc
    func checkboxTapped(sender: UIButton) {
        
        if sender.isSelected {
            DailyRoutineCollectionViewCell.sharedVariable-=1
        } else {
            DailyRoutineCollectionViewCell.sharedVariable+=1
        }
        sender.isSelected = !sender.isSelected
    }
    
}
