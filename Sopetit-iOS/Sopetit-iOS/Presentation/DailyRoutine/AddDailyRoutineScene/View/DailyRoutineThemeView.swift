//
//  DailyRoutineThemeView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

import SnapKit

final class DailyRoutineThemeView: UIView {
    
    // MARK: - UI Components
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        if SizeLiterals.Screen.screenHeight < 812 {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 12, right: 20)
        } else {
            layout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 12, right: 20)
        }
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension DailyRoutineThemeView {

    func setHierarchy() {
        self.addSubviews(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(97)
        }
    }
}
