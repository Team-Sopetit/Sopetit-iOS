//
//  AddDailyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

import SnapKit

final class AddDailyRoutineView: UIView {

    // MARK: - Properties
    
    private enum Const {
        static let itemSize = CGSize(width: 280, height: 398)
        static let itemSpacing = 20.0
        static let sideItem = insetX - itemSpacing
        
        static var insetX: CGFloat {
            (SizeLiterals.Screen.screenWidth - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    // MARK: - UI Components
    
    private let customNavigationBar: CustomNavigationBarView = {
        let navigation = CustomNavigationBarView()
        navigation.isBackButtonIncluded = true
        navigation.isTitleViewIncluded = true
        navigation.isTitleLabelIncluded = I18N.DailyRoutine.addDailyRoutine
        return navigation
    }()
    
    let dailyRoutineThemeView = DailyRoutineThemeView()
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray100
        return view
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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AddDailyRoutineView {

    func setUI() {
        self.backgroundColor = .SoftieBack
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    func setHierarchy() {
        self.addSubviews(customNavigationBar, dailyRoutineThemeView, divideView, collectionView, pageControl, addButton)
        
    }
    
    func setLayout() {
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        if SizeLiterals.Screen.screenHeight < 812 {
            dailyRoutineThemeView.snp.makeConstraints {
                $0.top.equalTo(customNavigationBar.snp.bottom)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(82)
            }
            
            divideView.snp.makeConstraints {
                $0.top.equalTo(dailyRoutineThemeView.snp.bottom)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(0)
            }
            
            collectionView.snp.makeConstraints {
                $0.top.equalTo(divideView.snp.bottom).offset(20)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(Const.itemSize.height)
            }
        } else {
            dailyRoutineThemeView.snp.makeConstraints {
                $0.top.equalTo(customNavigationBar.snp.bottom)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(97)
            }
            
            divideView.snp.makeConstraints {
                $0.top.equalTo(dailyRoutineThemeView.snp.bottom)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(1)
            }
            
            collectionView.snp.makeConstraints {
                $0.top.equalTo(divideView.snp.bottom).offset(30)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(Const.itemSize.height)
            }
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
}
