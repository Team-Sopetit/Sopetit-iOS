//
//  OngoingView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

class OngoingView: UIView {

    var isChallenge: Bool = false {
        didSet(status) {
            setRoutineView(challenge: isChallenge, daily: isDaily)
        }
    }
    
    var isDaily: Bool = false {
        didSet(status) {
            setRoutineView(challenge: isChallenge, daily: isDaily)
        }
    }
    
    private let dateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        return label
    }()
    
    let routineEmptyView = RoutineEmptyView(fromAchieve: false)
    
    let challengeRoutineEmptyView = ChallengeRoutineEmptyView()
    let challengeRoutineView = ChallengeRoutineView()
    
    let divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    let dailyRoutineEmptyView = DailyRoutineEmptyView()
    let dailyRoutineView = NewDailyRoutineView()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let dailyContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let dailyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.isScrollEnabled = false
        collectionView.scrollsToTop = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
        return collectionView
    }()
    
    let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.ActiveRoutine.icnAddButton, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    let cancelToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastCancel
        return imageView
    }()
    
    let notCottonToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastNotCotton
        return imageView
    }()
    
    let deleteToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastDelete
        return imageView
    }()
    
    let dailyInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950
        return view
    }()
    
    let dailyInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.popover
        return imageView
    }()
    
    let challengeInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.popoverChallenge
        return imageView
    }()
    
    let deleteToastChallengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastChallengeDelete
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        setDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OngoingView {
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        self.addSubviews(dateView, scrollView)
        dateView.addSubview(dateLabel)
        scrollView.addSubview(dailyContentView)
    }
    
    func setLayout() {
        dateView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        dailyContentView.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
    }
    
    func setDateLabel() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
}

extension OngoingView {
    
    func setRoutineView(challenge: Bool, daily: Bool) {
        if challenge == false && daily == false {
            self.dailyContentView.subviews.forEach { $0.removeFromSuperview() }
            self.floatingButton.removeFromSuperview()
            
            self.addSubviews(routineEmptyView)
            routineEmptyView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
        } else {
            self.routineEmptyView.removeFromSuperview()
            self.addSubviews(floatingButton)
            
            floatingButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(20)
                $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(12)
                $0.size.equalTo(50)
            }
            
            self.dailyContentView.addSubview(divisionView)
            
            if challenge == true {
                challengeRoutineEmptyView.removeFromSuperview()
                dailyContentView.addSubview(challengeRoutineView)
                challengeRoutineView.snp.makeConstraints {
                    $0.top.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(198)
                }
                
                divisionView.snp.makeConstraints {
                    $0.top.equalTo(challengeRoutineView.snp.bottom)
                    $0.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(2)
                }
            } else {
                challengeRoutineView.removeFromSuperview()
                dailyContentView.addSubview(challengeRoutineEmptyView)
                challengeRoutineEmptyView.snp.makeConstraints {
                    $0.top.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(140)
                }
                
                divisionView.snp.makeConstraints {
                    $0.top.equalTo(challengeRoutineEmptyView.snp.bottom)
                    $0.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(2)
                }
            }
            
            if daily == true {
                dailyRoutineEmptyView.removeFromSuperview()
                dailyContentView.addSubview(dailyRoutineView)
                dailyRoutineView.snp.makeConstraints {
                    $0.top.equalTo(divisionView)
                    $0.horizontalEdges.bottom.equalToSuperview()
                }
            } else {
                dailyRoutineView.removeFromSuperview()
                dailyContentView.addSubview(dailyRoutineEmptyView)
                dailyRoutineEmptyView.snp.makeConstraints {
                    $0.top.equalTo(divisionView)
                    $0.horizontalEdges.bottom.equalToSuperview()
                }
            }
        }
    }
}
