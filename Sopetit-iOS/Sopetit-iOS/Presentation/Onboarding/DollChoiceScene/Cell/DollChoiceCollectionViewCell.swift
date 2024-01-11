//
//  DollChoiceCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class DollChoiceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let dollImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.bearBrownDown
        image.contentMode = .scaleAspectFit
        return image
    }()
    
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

extension DollChoiceCollectionViewCell {

    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        addSubview(dollImage)
    }
    
    func setLayout() {
        dollImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(160)
        }
    }
    
    func setDataBind(image: UIImage) {
        dollImage.image = image
    }
}
