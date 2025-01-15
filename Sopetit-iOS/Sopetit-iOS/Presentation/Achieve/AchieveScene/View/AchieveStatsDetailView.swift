//
//  AchieveStatsDetailView.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/13/25.
//

import UIKit

import SnapKit

final class AchieveStatsDetailView: UIView {
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    let navigationBar: CustomNavigationBarView = {
        let navigation = CustomNavigationBarView()
        navigation.isBackButtonIncluded = true
        navigation.isTitleViewIncluded = true
        navigation.isTitleLabelIncluded = "달성한 루틴"
        return navigation
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    private let themeImageView = UIImageView()
    
    private let themeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let themeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.head2)
        return label
    }()
    
    // challenge cv
    
    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "챌린지"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        return label
    }()
    
    private let challengeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        return label
    }()
    
    lazy var challengeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let challengeEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let challengeEmptyImageView = UIImageView(image: UIImage(resource: .icInfo))
    
    private let challengeEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = "달성한 챌린지 루틴이 없어요"
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    // daily cv
    
    private let dailyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "데일리 루틴"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        return label
    }()
    
    private let dailyCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        return label
    }()
    
    lazy var dailyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let dailyEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let dailyEmptyImageView = UIImageView(image: UIImage(resource: .icInfo))
    
    private let dailyEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = "달성한 데일리 루틴이 없어요"
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
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

private extension AchieveStatsDetailView {
    
    func setUI() {
        backgroundColor = .Gray50
        challengeEmptyView.isHidden = true
        dailyEmptyView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationBar,
                    divideView,
                    scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(themeImageView,
                                themeTitleLabel,
                                themeCountLabel,
                                challengeTitleLabel,
                                challengeCountLabel,
                                challengeCollectionView,
                                challengeEmptyView,
                                dailyTitleLabel,
                                dailyCountLabel,
                                dailyCollectionView,
                                dailyEmptyView)
        challengeEmptyView.addSubviews(challengeEmptyImageView,
                                       challengeEmptyLabel)
        dailyEmptyView.addSubviews(dailyEmptyImageView,
                                   dailyEmptyLabel)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        themeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        themeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(themeImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        themeCountLabel.snp.makeConstraints {
            $0.top.equalTo(themeTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(themeCountLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        
        challengeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(challengeTitleLabel.snp.centerY)
            $0.leading.equalTo(challengeTitleLabel.snp.trailing).offset(6)
        }
        
        challengeCollectionView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        
        challengeEmptyView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(4)
            $0.width.equalToSuperview()
            $0.height.equalTo(116)
        }
        
        challengeEmptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        challengeEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(challengeEmptyImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        dailyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeCollectionView.snp.bottom).offset(16)
            $0.leading.equalTo(challengeTitleLabel.snp.leading)
        }
        
        dailyCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(dailyTitleLabel.snp.centerY)
            $0.leading.equalTo(dailyTitleLabel.snp.trailing).offset(6)
        }
        
        dailyCollectionView.snp.makeConstraints {
            $0.top.equalTo(dailyTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(100)
        }
        
        dailyEmptyView.snp.makeConstraints {
            $0.top.equalTo(dailyTitleLabel.snp.bottom).offset(4)
            $0.width.equalToSuperview()
            $0.height.equalTo(116)
        }
        
        dailyEmptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        dailyEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(dailyEmptyImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setRegisterCell() {
        StatsDetailCell.register(target: challengeCollectionView)
        StatsDetailCell.register(target: dailyCollectionView)
    }
}

extension AchieveStatsDetailView {
    
    func bindAchieveDetail(model: StatsRoutineInfo) {
        themeImageView.image = UIImage(named: "theme\(model.themeId)")
        themeTitleLabel.text = ThemeDetailEntity.getTheme(id: model.themeId).themeTitle
        themeCountLabel.text = "\(model.totalCount)번"
        themeTitleLabel.textColor = UIColor(named: "ThemeTitle\(model.themeId)")
        themeTitleLabel.asLineHeight(.body2)
        themeCountLabel.asLineHeight(.head2)
    }
    
    func bindTotalDetail(total: Int,
                         height: Double,
                         isChallenge: Bool) {
        if isChallenge {
            challengeCountLabel.text = "\(total)번"
            challengeCountLabel.asLineHeight(.body2)
            if total == 0 {
                challengeEmptyView.isHidden = false
                dailyTitleLabel.snp.updateConstraints {
                    $0.top.equalTo(challengeEmptyView.snp.bottom).offset(16)
                }
            } else {
                challengeCollectionView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
                
                dailyTitleLabel.snp.updateConstraints {
                    $0.top.equalTo(challengeCollectionView.snp.bottom).offset(16)
                }
            }
        } else {
            dailyCountLabel.text = "\(total)번"
            dailyCountLabel.asLineHeight(.body2)
            if total == 0 {
                dailyEmptyView.isHidden = false
            } else {
                dailyCollectionView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
            }
        }
    }
}
