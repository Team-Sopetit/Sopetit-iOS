//
//  DailyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

import SnapKit

final class DailyRoutineView: UIView {
    
    // MARK: - Properties
    
    var deleteButtonStatus: Bool = false {
        didSet {
            switch deleteButtonStatus {
            case true:
                enableDeleteButton()
            case false:
                disableDeleteButton()
            }
        }
    }
    // MARK: - UI Components
    
    let navigationBar: CustomNavigationBarView = {
        let view = CustomNavigationBarView()
        view.isLeftTitleViewIncluded = true
        view.isLeftTitleLabelIncluded = "데일리 루틴"
        view.isEditButtonIncluded = true
        return view
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 13, left: 20, bottom: 13, right: 20)
        layout.minimumInteritemSpacing = 11
        layout.scrollDirection = .vertical
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("0개 삭제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.backgroundColor = .Gray200
        button.layer.cornerRadius = 12
        button.isHidden = true
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

private extension DailyRoutineView {
    
    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBar, collectionView, deleteButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        deleteButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(27)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
    
    func enableDeleteButton() {
        deleteButton.backgroundColor = .SoftieRed
        deleteButton.isEnabled = true
    }
    
    func disableDeleteButton() {
        deleteButton.setTitle("0개 삭제", for: .normal)
        deleteButton.backgroundColor = .Gray200
        deleteButton.isEnabled = false
    }
}
