//
//  StatsDetailCell.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/13/25.
//

import UIKit

import SnapKit
import Foundation

final class StatsDetailCell: UICollectionViewCell,
                             UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let themeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대중교통 이용 시 기사님께 감사 인사하기"
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.numberOfLines = 0
        return label
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray300
        return view
    }()
    
    private let themeTimeImageView = UIImageView(image: UIImage(resource: .icTimeDetail))
    private let themeBackImageView = UIImageView(image: UIImage(resource: .themeHalf1))
    
    private let themeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1번 달성"
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.textAlignment = .right
        return label
    }()
    
    private let themeTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 1월 13일 마지막 달성"
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        return label
    }()
    
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

private extension StatsDetailCell {
    
    func setUI() {
        backgroundColor = .SoftieWhite
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.Gray200.cgColor
    }
    
    func setHierarchy() {
        addSubviews(themeTitleLabel,
                    divideView,
                    themeTimeImageView,
                    themeCountLabel,
                    themeTimeLabel,
                    themeBackImageView)
    }
    
    func setLayout() {
        themeTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(themeTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        themeTimeImageView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(10)
            $0.leading.equalTo(themeTitleLabel.snp.leading)
            $0.size.equalTo(18)
        }
        
        themeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(themeTimeImageView.snp.centerY)
            $0.leading.equalTo(themeTimeImageView.snp.trailing).offset(6)
        }
        
        themeTimeLabel.snp.makeConstraints {
            $0.top.equalTo(themeCountLabel.snp.bottom).offset(4)
            $0.leading.equalTo(themeCountLabel.snp.leading)
        }
        
        themeBackImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(3)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.equalTo(113)
            $0.height.equalTo(68)
        }
    }
}

extension StatsDetailCell {
    
    func bindStatsDetail(entity: ThemeChallenge,
                         themeId: Int,
                         isChallenge: Bool) {
        themeTitleLabel.text = entity.content.replacingOccurrences(of: "\n", with: " ")
        themeCountLabel.text = "\(entity.achievedCount)번 달성"
        themeTitleLabel.asLineHeight(.body2)
        themeCountLabel.asLineHeight(.body2)
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: entity.startedAt) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy년 MM월 dd일"
            let formattedDate = outputFormatter.string(from: date)
            themeTimeLabel.text = isChallenge ? "\(formattedDate) 마지막 달성" : "\(formattedDate)부터 지금까지"
        }
        
        themeBackImageView.isHidden = !isChallenge
        themeBackImageView.image = UIImage(named: "theme_half_\(themeId)")
        self.backgroundColor = isChallenge ? UIColor(named: "ThemeBack\(themeId)") : .SoftieWhite
    }
}
