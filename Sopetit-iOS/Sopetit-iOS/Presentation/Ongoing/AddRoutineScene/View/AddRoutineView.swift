//
//  AddRoutineView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class AddRoutineView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        navi.isTitleViewIncluded = true
        navi.isTitleLabelIncluded = "루틴 추가"
        return navi
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    
    // addCustomRoutine
    
    let addCustomRoutineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.Gray650.cgColor,
                           UIColor.Gray700.cgColor]
        gradient.locations = [0.0, 0.46]
        return gradient
    }()
    
    private let customSubLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 루틴이 없다면?"
        label.textColor = .Gray300
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        return label
    }()
    
    private let customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나만의 루틴 만들기"
        label.textColor = .SoftieWhite
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let customBearImage: UIImageView = UIImageView(
        image: UIImage(
            resource: .imgCustomBear
        )
    )
    
    private let customRoutineButton: UIImageView = UIImageView(
        image: UIImage(
            resource: .icNext
        )
    )
    
    // addRoutine
    
    private let totalRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "전체 루틴 테마"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    lazy var totalRoutineCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
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

        setGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AddRoutineView {
    
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setGradient() {
        gradientLayer.frame = addCustomRoutineView.bounds
        gradientLayer.zPosition = -1
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        addCustomRoutineView.layer.addSublayer(gradientLayer)
    }
    
    func setHierarchy() {
        addSubviews(navigationView,
                    scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(addCustomRoutineView,
                                totalRoutineTitle,
                                totalRoutineCollectionView)
        addCustomRoutineView.addSubviews(
            customSubLabel,
            customTitleLabel,
            customRoutineButton,
            customBearImage
        )
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        addCustomRoutineView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(76)
        }
        
        customSubLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        customTitleLabel.snp.makeConstraints {
            $0.top.equalTo(customSubLabel.snp.bottom).offset(2)
            $0.leading.equalTo(customSubLabel.snp.leading)
        }
        
        customRoutineButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
        
        customBearImage.snp.makeConstraints {
            $0.trailing.equalTo(customRoutineButton.snp.leading).offset(-4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalTo(76)
        }
        
        totalRoutineTitle.snp.makeConstraints {
            $0.top.equalTo(addCustomRoutineView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        totalRoutineCollectionView.snp.makeConstraints {
            $0.top.equalTo(totalRoutineTitle.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(630)
        }
    }
    
    func setRegisterCell() {
        TotalRoutineCollectionViewCell.register(target: totalRoutineCollectionView)
    }
}
