//
//  ThemeSelectView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class ThemeSelectView: UIView {

    // MARK: - Properties
    
    var dollName: String = "애착이"
    
    // MARK: - UI Components
    
    private let progressView = CustomProgressView(progressNum: 3)
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.isUserInteractionEnabled = true
        return view
    }()
    
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
        label.text = "안녕 난 \(dollName)야!\n나와 함께 루틴을 만들어볼까?"
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = SizeLiterals.Screen.screenWidth * 36 / 375
        flowLayout.minimumLineSpacing = SizeLiterals.Screen.screenHeight * 28 / 812
        flowLayout.itemSize = CGSize(width: 70, height: 95)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .SoftieBack
        return collectionView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.themeButtonTitle, for: .normal)
        button.setTitleColor(.Gray300, for: .disabled)
        button.setTitleColor(.Gray000, for: .normal)
        button.setBackgroundColor(.Gray100, for: .disabled)
        button.setBackgroundColor(.SoftieMain1, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
        setGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ThemeSelectView {

    func setUI() {
        backgroundColor = .SoftieBack
        bubbleLabel.partColorChange(targetString: dollName, textColor: .SoftieBrown)
    }
    
    func setHierarchy() {
        bubbleImage.addSubview(bubbleLabel)
        addSubviews(progressView, collectionView, nextButton, backgroundView, bearImage, bubbleImage)
    }
    
    func setLayout() {
        progressView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(23)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
            $0.top.equalTo(bubbleLabel.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 282 / 375)
            $0.bottom.equalTo(nextButton.snp.top).offset(-SizeLiterals.Screen.screenHeight * 49 / 812)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(56)
        }
    }

    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func viewTapped() {
        backgroundView.isHidden = true
        bubbleLabel.text = I18N.Onboarding.themeTitle
    }
    
    func setRegisterCell() {
        ThemeSelectCollectionViewCell.register(target: collectionView)
    }
}
