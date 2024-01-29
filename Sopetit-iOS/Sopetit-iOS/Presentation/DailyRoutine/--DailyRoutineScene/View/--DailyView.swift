//
//  RoutineView.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit

import SnapKit

final class ExDailyView: UIView {
    
    // MARK: - UI Components

    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .SoftieBack
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ExDailyView {

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
        ExDailyRoutineCollectionViewCell.register(target: collectionView)
        ExDailyFooterView.register(target: collectionView)
    }
}
