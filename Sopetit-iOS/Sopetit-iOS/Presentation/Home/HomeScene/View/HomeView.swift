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

public enum LottieFrameTime: CGFloat {
    case start = 0
    case eatDaily = 21
    case eatHappy = 45
    case end = 68
}

final class HomeView: UIView {
    
    // MARK: - Properties
    
    var isAnimate: Bool = false
    var bubbleLabelList: [String] = []
    
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
    
    var animationView: LottieAnimationView
    
    let bubbleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .fontGuide(.bubble1)
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
        label.font = .fontGuide(.bubble2)
        label.backgroundColor = .Brown100
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Brown200.cgColor
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
    
    private let tooltipImageView = UIImageView(image: UIImage(resource: .imgTooltipSetting))
    let feedbackAlertView: FeedbackAlertView = {
        let view = FeedbackAlertView()
        view.isHidden = !(UserManager.shared.getShowFeedBack && UserManager.shared.getShowFeedBackAlert)
        return view
    }()
    
    // MARK: - Life Cycles
    
    init() {
        animationView = LottieAnimationView()
        super.init(frame: .zero)
        
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
            let allAnimation = LottieAnimation.named("\(dollType.lowercased())_all")
            self.animationView.animation = allAnimation
        }
    }
}

extension HomeView {
    
    func setHierarchy() {
        self.addSubviews(
            backgroundImageView,
            softieImageView,
            moneyButton,
            settingButton,
            bubbleImageView,
            shadowImageView,
            dollNameLabel,
            actionCollectionView
        )
                
        bubbleImageView.addSubview(bubbleLabel)
        
        addSubviews(animationView)
        self.bringSubviewToFront(actionCollectionView)
        addSubview(feedbackAlertView)
        self.bringSubviewToFront(feedbackAlertView)
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
            $0.top.equalTo(animationView.snp.top).inset(22)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-4)
        }
        
        animationView.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        shadowImageView.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(23)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(animationView.snp.bottom).offset(-105)
        }
        
        dollNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(animationView.snp.bottom).inset(54)
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
        
        if UserManager.shared.getShowFeedBack && !UserManager.shared.getShowFeedBackAlert {
            self.addSubview(tooltipImageView)
            
            tooltipImageView.snp.makeConstraints {
                $0.top.equalTo(settingButton.snp.bottom).offset(1)
                $0.trailing.equalToSuperview().inset(16)
                $0.width.equalTo(108)
                $0.height.equalTo(33)
            }
        }
        
        feedbackAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        let dollTapGesture: UIGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dollTapped)
        )
        animationView.addGestureRecognizer(dollTapGesture)
    }
    
    @objc
    func dollTapped() {
        if !(isAnimate) && !bubbleLabelList.isEmpty {
            isAnimate = true
            animationView.play(fromFrame: LottieFrameTime.start.rawValue,
                                         toFrame: LottieFrameTime.eatDaily.rawValue,
                                         loopMode: .playOnce)
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
        setDoll(dollType: UserManager.shared.getDollType)
        refreshBubbleLabel()
        dollNameLabel.text = model.name
        backgroundImageView.image = UIImage(named: "img_homeback_all_\(model.dollType.lowercased())")
    }
}
