//
//  StatsRoutineCell.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/8/25.
//

import UIKit

import SnapKit

struct StatsRoutineInfo {
    let themeId: Int
    let totalCount: Int
}

protocol StatsRoutineDelegate: AnyObject {
    func selectedCell(_ cellInfo: StatsRoutineInfo)
}

final class StatsRoutineCell: UICollectionViewCell,
                              UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    weak var delegate: StatsRoutineDelegate?
    private var cellInfo: StatsRoutineInfo?
    
    // MARK: - UI Components
    
    private let themeIconImageView = UIImageView(image: UIImage(resource: .themeFull1))
    
    private let themeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관계쌓기"
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let themeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "40번"
        label.textColor = .Gray700
        label.font = .fontGuide(.head2)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension StatsRoutineCell {
    
    func setUI() {
        backgroundColor = .SoftieWhite
        layer.cornerRadius = 12
    }
    
    func setHierarchy() {
        addSubviews(themeIconImageView,
                    themeCountLabel,
                    themeTitleLabel)
    }
    
    func setLayout() {
        themeIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(32)
        }
        
        themeCountLabel.snp.makeConstraints {
            $0.top.equalTo(themeIconImageView.snp.top)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        themeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(themeIconImageView.snp.leading)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
    
    func setAddGesture() {
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(cellTapGesture)
    }
    
    @objc
    func cellTapped() {
        delegate?.selectedCell(self.cellInfo ?? StatsRoutineInfo(themeId: 0,
                                                                 totalCount: 0))
    }
}

extension StatsRoutineCell {
    
    func bindStatsRoutine(entity: AchieveTheme) {
        themeIconImageView.image = UIImage(named: "theme_full_\(entity.id)")
        themeTitleLabel.text = entity.name
        themeCountLabel.text = "\(entity.achievedCount)번"
        themeTitleLabel.asLineHeight(.body2)
        themeCountLabel.asLineHeight(.head2)
        self.cellInfo = StatsRoutineInfo(themeId: entity.id,
                                         totalCount: entity.achievedCount)
    }
}
