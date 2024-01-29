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
    
    
    // MARK: - UI Components
    
    private let navigationBar: CustomNavigationBarView = {
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

extension DailyRoutineView {

    func setUI() {
        
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBar, collectionView)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        
    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}
