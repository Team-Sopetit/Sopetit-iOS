//
//  RoutineChoiceView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class RoutineChoiceView: UIView {

    // MARK: - UI Components
    
    private let progressView = CustomProgressView(progressNum: 4)
    
    private let bearImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.imgFaceBrown
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let bubbleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.svgSpeechLong
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.routineChoiceTitle
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .SoftieBack
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 22, bottom: 30, right: 22)
        return collectionView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.routineBackButtonTitle, for: .normal)
        button.setTitleColor(.Gray300, for: .normal)
        button.setBackgroundColor(.Gray100, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.routineNextButtonTitle, for: .normal)
        button.setTitleColor(.Gray000, for: .normal)
        button.setBackgroundColor(.SoftieMain1, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var topLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.SoftieBack.withAlphaComponent(1).cgColor, UIColor.SoftieBack.withAlphaComponent(0.9).cgColor, UIColor.SoftieBack.withAlphaComponent(0).cgColor]
        gradient.frame = CGRect(x: SizeLiterals.Screen.screenWidth * 20 / 375, y: 155 + SizeLiterals.Screen.screenHeight * 24 / 812, width: SizeLiterals.Screen.screenWidth * 335 / 375, height: 30)
        return gradient
    }()
    
    private lazy var bottomLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.SoftieBack.withAlphaComponent(0).cgColor, UIColor.SoftieBack.withAlphaComponent(0.9).cgColor, UIColor.SoftieBack.withAlphaComponent(1).cgColor]
        gradient.frame = CGRect(x: SizeLiterals.Screen.screenWidth * 20 / 375, y: 129 + SizeLiterals.Screen.screenHeight * 464 / 812, width: SizeLiterals.Screen.screenWidth * 335 / 375, height: 30)
        return gradient
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.routineInfoTitle
        label.textColor = .SoftieRed
        label.font = .fontGuide(.body4)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.addSublayer(topLayer)
        self.layer.addSublayer(bottomLayer)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension RoutineChoiceView {

    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        bubbleImage.addSubview(bubbleLabel)
        addSubviews(progressView, bearImage, bubbleImage, collectionView, backButton, nextButton, infoLabel)
    }
    
    func setLayout() {
        progressView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(23)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        bearImage.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(53)
            $0.height.equalTo(50)
        }
        
        bubbleImage.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(23)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(248)
            $0.height.equalTo(60)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bubbleImage.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 24 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 351 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 440 / 812)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 51) / 2)
            $0.height.equalTo(56)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 51) / 2)
            $0.height.equalTo(56)
        }
        
        infoLabel.snp.makeConstraints {
            $0.bottom.equalTo(backButton.snp.top).offset(-SizeLiterals.Screen.screenHeight * 27 / 812)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setRegisterCell() {
        RoutineChoiceCollectionViewCell.register(target: collectionView)
    }
    
    func setDataBind(model: DollImageEntity) {
        bearImage.kfSetImage(url: model.faceImageURL)
    }
}
