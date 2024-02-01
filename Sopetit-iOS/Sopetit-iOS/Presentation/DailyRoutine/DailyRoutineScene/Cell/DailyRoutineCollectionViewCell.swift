//
//  DailyRoutineCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

import SnapKit

protocol ConfirmDelegate: AnyObject {
    func tapButton(index: Int)
}

protocol RadioButtonDelegate: AnyObject {
    
    func selectRadioButton(index: Int)
    func unselectRadioButton(index: Int)
}

final class DailyRoutineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    private var index: Int = 0
    private var isEnabled: Bool = true {
        didSet {
            switch isEnabled {
            case true:
                completeButton.isEnabled = true
                completeButton.setTitle(I18N.DailyRoutine.complete, for: .normal)
                completeButton.backgroundColor = .SoftieMain1
                completeButton.setTitleColor(.SoftieWhite, for: .normal)
            case false:
                completeButton.isEnabled = false
                completeButton.setTitle(I18N.DailyRoutine.completed, for: .normal)
                completeButton.backgroundColor = .Gray100
                completeButton.setTitleColor(.Gray300, for: .normal)
            }
        }
    }
    
    var radioStatus: Bool = false {
        didSet {
            switch radioStatus {
            case true:
                radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnSelected, for: .normal)
                radioDelegate?.selectRadioButton(index: self.index)
            case false:
                radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)
                radioDelegate?.unselectRadioButton(index: self.index)

            }
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            switch isEditing {
            case true:
                radioButton.isHidden = false
                radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)

            case false:
                radioButton.isHidden = true
            }
        }
    }
    
    weak var delegate: ConfirmDelegate?
    weak var radioDelegate: RadioButtonDelegate?
    
    // MARK: - UI Components
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.variant6
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let routineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray700
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
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
    
    private lazy var radioButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .fontGuide(.body4)
        button.layer.cornerRadius = 10
        return button
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        radioButton.isHidden = true
        radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)
    }
}

// MARK: - Extensions

private extension DailyRoutineCollectionViewCell {

    func setUI() {
        self.backgroundColor = .SoftieWhite
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner])
        self.layer.borderColor = UIColor.Gray100.cgColor
        self.layer.borderWidth = 1
    }
    
    func setHierarchy() {
        self.addSubviews(routineView, radioButton, completeButton)
        routineView.addSubviews(iconImageView, titleLabel, flagImageView, achieveLabel)
    }
    
    func setLayout() {
        routineView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(23)
            $0.trailing.equalToSuperview().inset(57)
            $0.height.greaterThanOrEqualTo(40)
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.height.greaterThanOrEqualTo(19)
        }
    
        flagImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.size.equalTo(12)
        }
        
        achieveLabel.snp.makeConstraints {
            $0.leading.equalTo(flagImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(flagImageView.snp.centerY)
        }
        
        radioButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(11)
            $0.size.equalTo(38)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }
    }

    func setAddTarget() {
        completeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        radioButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        switch sender {
        case completeButton:
            delegate?.tapButton(index: self.index)
        case radioButton:
            radioStatus.toggle()
        default:
            break
        }
    }
}

extension DailyRoutineCollectionViewCell {
    
    func setDataBind(model: DailyRoutines, index: Int) {
        if let iconURL = URL(string: model.iconImageURL) {
            iconImageView.downloadedsvg(from: iconURL)
        }
        titleLabel.text = model.content
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 24)
        achieveLabel.text = "\(model.achieveCount)번째 달성 중"
        self.layoutIfNeeded()
        self.index = index
        self.isEnabled = !model.isAchieve
    }
    
    func setEdit() {
        self.radioButton.isHidden = false
    }
    
    func setEndEdit() {
        self.radioButton.isHidden = true
    }
}
