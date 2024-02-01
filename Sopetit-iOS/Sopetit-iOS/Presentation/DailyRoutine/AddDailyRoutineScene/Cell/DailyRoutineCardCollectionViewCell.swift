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
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.imgDailycardEmpty
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head1)
        label.textColor = .Gray700
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 4)
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
}

// MARK: - Extensions

private extension DailyRoutineCardCollectionViewCell {
    
    func setHierarchy() {
        self.addSubviews(cardImageView, titleLabel)
    }
    
    func setLayout() {
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(192)
        }
    }
}

extension DailyRoutineCardCollectionViewCell {
    
    func setDataBind(model: DailyRoutine, imageURL: String) {
        cardImageView.kfSetImage(url: imageURL)
        titleLabel.text = model.content
        titleLabel.textAlignment = .center
    }
}
