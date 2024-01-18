//
//  RoutineView.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit

import SnapKit

final class DailyView: UIView {
    
    // MARK: - UI Components

    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SizeLiterals.Screen.screenWidth - 40), height: 136)
        layout.footerReferenceSize = CGSize(width: (SizeLiterals.Screen.screenWidth - 40), height: 136)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)

        layout.minimumLineSpacing = 12
        view.contentInsetAdjustmentBehavior = .always
        view.backgroundColor = .SoftieBack
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DailyView {

    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
        }
    }
    
    func setRegisterCell() {
        DailyRoutineCollectionViewCell.register(target: collectionView)
        DailyFooterView.register(target: collectionView)
    }
}
