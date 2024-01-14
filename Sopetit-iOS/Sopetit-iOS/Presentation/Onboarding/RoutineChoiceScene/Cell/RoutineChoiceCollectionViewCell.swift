//
//  RoutineChoiceCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class RoutineChoiceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    let routineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .SoftieWhite
        label.layer.borderColor = UIColor.Gray100.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 25
        label.clipsToBounds = true
        label.textColor = .Gray400
        label.font = .fontGuide(.body2)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isSelected = false
        routineLabel.backgroundColor = .SoftieWhite
        routineLabel.layer.borderColor = UIColor.Gray100.cgColor
        routineLabel.layer.borderWidth = 1
    }
}

// MARK: - Extensions

extension RoutineChoiceCollectionViewCell {

    func setHierarchy() {
        addSubview(routineLabel)
    }
    
    func setLayout() {
        routineLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setDataBind(model: Routine) {
        routineLabel.text = model.content
        if model.content.contains("\n") {
            routineLabel.layer.cornerRadius = 35
        } else {
            routineLabel.layer.cornerRadius = 25
        }
    }
    
    func setCellSelected(selected: Bool) {
        isSelected = selected
        routineLabel.backgroundColor = selected ? .Gray100 : .SoftieWhite
        routineLabel.layer.borderColor = selected ? UIColor.Gray400.cgColor : UIColor.Gray100.cgColor
        routineLabel.layer.borderWidth = selected ? 2 : 1
    }
}
