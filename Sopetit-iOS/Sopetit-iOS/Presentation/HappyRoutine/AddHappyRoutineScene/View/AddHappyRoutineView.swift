//
//  AddHappyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/10/24.
//

import UIKit

import SnapKit

protocol HappyRoutineProtocol: AnyObject {
    
    func tapAddButton()
}

final class AddHappyRoutineView: UIView {

    // MARK: - Properties
    weak var delegate: HappyRoutineProtocol?
    
    private enum Const {
        static let itemSize = CGSize(width: 280, height: 398)
        static let itemSpacing = 20.0
        static let sideItem = insetX - itemSpacing
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    // MARK: - UI Components
    private let customNavigationBar: CustomNavigationBarView = {
        let navigation = CustomNavigationBarView()
        navigation.isBackButtonIncluded = true
        return navigation
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textAlignment = .center
        return label
    }()
    
    private let blingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head1)
        label.textColor = .Gray500
        return label
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(HappyRoutineCardCollectionViewCell.self, forCellWithReuseIdentifier: "HappyRoutineCardCollectionViewCell")
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = Const.collectionViewContentInset
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.frame.maxY - 100, width: self.frame.maxX, height: 50))
        pageControl.numberOfPages = 7
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .Gray200
        pageControl.currentPageIndicatorTintColor = .SoftieMain1
        return pageControl
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.HappyRoutine.addHappyRoutineButton, for: .normal)
        button.setTitleColor(.Gray000, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.backgroundColor = .SoftieMain1
        button.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AddHappyRoutineView {

    func setUI() {
        self.backgroundColor = .SoftieBack
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    func setHierarchy() {
        self.addSubviews(customNavigationBar, titleLabel, blingImageView, subTitleLabel, collectionView, pageControl, addButton)
    }
    
    func setLayout() {
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        blingImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.width.equalTo(18)
            $0.height.equalTo(22)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(blingImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Const.itemSize.height)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(56 * SizeLiterals.Screen.screenHeight / 812)
        }
    }
    
    func setAddTarget() {
        addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        print("AddButton Tapped")
        delegate?.tapAddButton()
    }
    
    func setDataBind(title: String, image: UIImage, subTitle: String, color: UIColor) {
        titleLabel.text = title
        blingImageView.image = image
        subTitleLabel.text = subTitle
        titleLabel.textColor = color
    }
}
