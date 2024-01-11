//
//  HomeView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit

final class HomeView: UIView {

    // MARK: - Properties
    
    private let name = "애착이"
    private var dollWidth: CGFloat = 0.0
    
    // MARK: - UI Components
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.imgHomebackAllGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let softieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.icLogoHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var moneyButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeMoney, for: .normal)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeSettings, for: .normal)
        return button
    }()
    
    private let bubbleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.pngSpeechHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 하루는 어땠어?\n나한테 얘기해주라!"
        label.numberOfLines = 2
        label.font = .fontGuide(.bubble18)
        return label
    }()
    
    private let dollImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.imgBearHomeGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dollNameLabel: UILabel = {
        let label = UILabel()
        label.text = "애착이"
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble16)
        label.backgroundColor = UIColor.SoftieHomeFill
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.SoftieHomeStroke.cgColor
        label.layer.cornerRadius = 17
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var actionCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 15
            flowLayout.itemSize = CGSize(width: 160, height: 80)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.clipsToBounds = true
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.isUserInteractionEnabled = true
            collectionView.allowsSelection = false
            collectionView.backgroundColor = .clear
            return collectionView
        }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension HomeView {

    func setUI() {
        dollWidth = name.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.bubble16)]).width
    }
    
    func setHierarchy() {
        self.addSubviews(backgroundImageView, softieImageView, moneyButton, settingButton, bubbleImageView, dollImageView, dollNameLabel, actionCollectionView)
        
        bubbleImageView.addSubview(bubbleLabel)
    }
    
    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        softieImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moneyButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-20)
        }
        
        settingButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(68)
            $0.bottom.equalTo(dollImageView.snp.top)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-4)
        }
        
        dollImageView.snp.makeConstraints {
            $0.width.equalTo(165)
            $0.height.equalTo(182)
            $0.center.equalToSuperview()
        }
        
        dollNameLabel.snp.makeConstraints {
            $0.top.equalTo(dollImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(dollWidth + 26)
            $0.height.equalTo(34)
        }
        
        actionCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(106)
            $0.height.equalTo(100)
        }
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        ActionCollectionViewCell.register(target: actionCollectionView)
    }
    
    func setDataBind() {
        
    }
}
