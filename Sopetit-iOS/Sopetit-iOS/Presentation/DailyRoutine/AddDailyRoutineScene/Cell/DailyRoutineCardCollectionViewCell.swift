//
//  DailyRoutineCardCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

import SnapKit

final class DailyRoutineCardCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DailyRoutineCardCollectionViewCell {

    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
}
