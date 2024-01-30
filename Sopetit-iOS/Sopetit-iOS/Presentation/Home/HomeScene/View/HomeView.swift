//
//  HomeView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit
import Lottie
import Kingfisher

final class HomeView: UIView {
    
    // MARK: - Properties
    
    var isAnimate: Bool = false
    private var bubbleLabelList: [String] = []
    
    // MARK: - UI Components
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.imgHomebackAll
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let softieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.icLogoHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var moneyButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeMoney, for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        return button
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeSettings, for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        return button
    }()
    
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.pngSpeechHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var lottieHello: LottieAnimationView
    var lottieEatingDaily: LottieAnimationView
    var lottieEatingHappy: LottieAnimationView
    
    let bubbleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .fontGuide(.bubble18)
        label.textAlignment = .center
        return label
    }()
    
    private let shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.imgShadow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let dollNameLabel: UILabel = {
        let label = UILabel()
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
        flowLayout.minimumInteritemSpacing = SizeLiterals.Screen.screenWidth * 4 / 375
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth * 160 / 375, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    init() {
        lottieHello = LottieAnimationView()
        lottieEatingDaily = LottieAnimationView()
        lottieEatingHappy = LottieAnimationView()
        super.init(frame: .zero)
        
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
    func setDoll(dollType: String) {
        DispatchQueue.main.async {
            let helloAnimation = LottieAnimation.named("\(dollType.lowercased())_hello")
            self.lottieHello.animation = helloAnimation
            let eatingDailyAnimation = LottieAnimation.named("\(dollType.lowercased())_eating_daily")
            self.lottieEatingDaily.animation = eatingDailyAnimation
            let eatingHappyAnimation = LottieAnimation.named("\(dollType.lowercased())_eating_happy")
            self.lottieEatingHappy.animation = eatingHappyAnimation
        }
    }
}

extension HomeView {
    
    func setUI() {
        lottieHello.isHidden = false
        lottieEatingDaily.isHidden = true
        lottieEatingHappy.isHidden = true
    }
    
    func setHierarchy() {
        self.addSubviews(backgroundImageView, softieImageView, moneyButton, settingButton, bubbleImageView, shadowImageView, dollNameLabel, actionCollectionView)
                
        bubbleImageView.addSubview(bubbleLabel)
        
        addSubviews(lottieEatingDaily, lottieEatingHappy, lottieHello)
        self.bringSubviewToFront(actionCollectionView)
    }
    
    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        softieImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(11)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moneyButton.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.top.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-6)
        }
        
        settingButton.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.top.equalTo(safeAreaLayoutGuide).offset(1)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(68)
            $0.top.equalTo(lottieHello.snp.top).inset(22)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-4)
        }
        
        lottieEatingDaily.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        lottieEatingHappy.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        lottieHello.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        shadowImageView.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(23)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(lottieHello.snp.bottom).offset(-105)
        }
        
        dollNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(lottieHello.snp.bottom).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(63)
            $0.height.equalTo(34)
        }
        
        actionCollectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 90 / 812)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 331 / 375)
            $0.height.equalTo(100)
        }
    }
    
    func setAddTarget() {
        let dollTapGesture: UIGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dollTapped)
        )
        lottieHello.addGestureRecognizer(dollTapGesture)
    }
    
    @objc
    func dollTapped() {
        if !(isAnimate) {
            isAnimate = true
            lottieHello.isHidden = false
            lottieEatingDaily.isHidden = true
            lottieEatingHappy.isHidden = true
            lottieHello.loopMode = .playOnce
            lottieHello.play()
            refreshBubbleLabel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                self.isAnimate = false
            }
        }
    }
    
    func setRegisterCell() {
        ActionCollectionViewCell.register(target: actionCollectionView)
    }
    
    func refreshBubbleLabel() {
        bubbleLabel.text = bubbleLabelList[Int.random(in: (0 ..< bubbleLabelList.count))]
    }
    
    func setDataBind(model: HomeEntity) {
        UserManager.shared.updateDoll(model.dollType)
        bubbleLabelList = model.conversations
        refreshBubbleLabel()
        dollNameLabel.text = model.name
        guard let url = URL(string: model.frameImageURL) else {return}
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let image):
                self.backgroundImageView.image = image.image
            case .failure:
                return
            }
        }
    }
}
