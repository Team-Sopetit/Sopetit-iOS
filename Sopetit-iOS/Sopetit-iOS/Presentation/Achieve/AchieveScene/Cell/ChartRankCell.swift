//
//  ChartRankCell.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/10/25.
//


import UIKit

import SnapKit

final class ChartRankCell: UICollectionViewCell,
                           UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let chartRankColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brown100
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let chartRankTitle: UILabel = {
        let label = UILabel()
        label.text = "관계쌓기"
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let chartPercent: UILabel = {
        let label = UILabel()
        label.text = "40%"
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.textAlignment = .right
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

private extension ChartRankCell {
    
    func setUI() {
        backgroundColor = .SoftieWhite
    }
    
    func setHierarchy() {
        addSubviews(chartRankColorView,
                    chartPercent,
                    chartRankTitle)
    }
    
    func setLayout() {
        chartRankColorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(12)
        }
        
        chartRankTitle.snp.makeConstraints {
            $0.leading.equalTo(chartRankColorView.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
        
        chartPercent.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

extension ChartRankCell {
    
    func bindChartRankCell(entity: AchieveRankEntity) {
        chartRankColorView.backgroundColor = UIColor(named: "ThemeChart\(entity.themeId)") ?? UIColor()
        chartRankTitle.text = ThemeDetailEntity.getFullTheme(id: entity.themeId).themeTitle
        chartPercent.text = "\(entity.percent)%"
        chartRankTitle.asLineHeight(.caption1)
        chartPercent.asLineHeight(.body2)
    }
}
