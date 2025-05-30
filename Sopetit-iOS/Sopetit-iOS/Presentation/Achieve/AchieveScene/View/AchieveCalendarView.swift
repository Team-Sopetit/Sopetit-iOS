//
//  AchieveCalendarView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 12/26/24.
//

import UIKit

import SnapKit
import FSCalendar

final class AchieveCalendarView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    let calendarHeaderView = CalendarHeaderView()
    
    let achieveCalendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.placeholderType = .none
        calendar.appearance.selectionColor = .clear
        calendar.appearance.todayColor = .none
        calendar.appearance.titleTodayColor = .none
        calendar.appearance.titleSelectionColor = .none
        calendar.appearance.borderSelectionColor = .clear
        calendar.appearance.borderDefaultColor = .clear
        calendar.scope = .month
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 0
        calendar.weekdayHeight = 32
        calendar.rowHeight = 70
        calendar.scrollEnabled = true
        calendar.appearance.weekdayFont = .fontGuide(.body2)
        calendar.appearance.weekdayTextColor = .Gray400
        return calendar
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    private let selectDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        return label
    }()
    
    private let selectDateCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let selectDateMemoTopDotView = UIImageView(image: UIImage(resource: .imgDot))
    private let selectDateMemoBottomDotView = UIImageView(image: UIImage(resource: .imgDot))
    
    let memoGuideImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(resource: .imgMemoGuide)
        return imageview
    }()
    
    let addMemoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnAddMemo), for: .normal)
        return button
    }()
    
    let bearFaceImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "img_memo_\(UserManager.shared.getDollType.lowercased())")
        imageview.isUserInteractionEnabled = true
        return imageview
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.textAlignment = .left
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let emptyBearImage = UIImageView(image: UIImage(resource: .emptyroutine))
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "달성한 루틴이 없어요"
        label.textColor = .Gray500
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    let achieveCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        collectionView.isScrollEnabled = false
        collectionView.scrollsToTop = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 56)
        layout.headerReferenceSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 22)
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

private extension AchieveCalendarView {
    
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(calendarHeaderView,
                                achieveCalendarView,
                                divideView,
                                addMemoButton,
                                memoGuideImage,
                                selectDateLabel,
                                selectDateCountLabel)
    }
    
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        calendarHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(26)
        }
        
        achieveCalendarView.snp.makeConstraints {
            $0.top.equalTo(calendarHeaderView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 47)
            $0.height.equalTo(400)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(achieveCalendarView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        addMemoButton.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(32)
        }
        
        memoGuideImage.snp.makeConstraints {
            $0.bottom.equalTo(addMemoButton.snp.top).offset(-4)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.equalTo(85)
            $0.height.equalTo(33)
        }
        
        selectDateLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        selectDateCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectDateLabel)
            $0.leading.equalTo(selectDateLabel.snp.trailing).offset(4)
        }
    }
    
    func setRegisterCell() {
        CalendarHistoryCell.register(target: achieveCollectionView)
        NewDailyRoutineHeaderView.register(target: achieveCollectionView)
    }
}

extension AchieveCalendarView {
    
    func bindSelectDate(date: String, week: String) {
        selectDateLabel.text = "\(date)일 (\(week))"
        selectDateLabel.asLineHeight(.head3)
    }
    
    func bindSelectDateCount(cnt: Int) {
        selectDateCountLabel.text = "\(cnt)개"
        selectDateCountLabel.partColorChange(targetString: String(cnt), textColor: .Red200)
        selectDateCountLabel.asLineHeight(.body2)
    }
    
    func bindIsEmptyView(isEmpty: Bool) {
        [bearFaceImage, memoLabel, selectDateMemoTopDotView, selectDateMemoBottomDotView, achieveCollectionView].forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        
        addMemoButton.isHidden = true
        memoGuideImage.isHidden = true
        contentView.addSubviews(emptyBearImage, emptyLabel)
        emptyBearImage.snp.makeConstraints {
            $0.top.equalTo(selectDateLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 36 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(120)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyBearImage.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func bindIsMemo(isRecord: Bool, height: Double, memo: String) {
        [emptyBearImage, emptyLabel, bearFaceImage, memoLabel, selectDateMemoTopDotView, selectDateMemoBottomDotView, achieveCollectionView].forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        let memoHeight = heightForView(text: memo, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 110)
        
        if isRecord {
            contentView.addSubviews(bearFaceImage, memoLabel, selectDateMemoTopDotView, selectDateMemoBottomDotView)
            
            memoLabel.text = memo
            memoLabel.asLineHeight(.body2)
        }
        contentView.addSubview(achieveCollectionView)
        
        if isRecord {
            selectDateMemoTopDotView.snp.makeConstraints {
                $0.bottom.equalTo(memoHeight <= 49 ? bearFaceImage.snp.top : memoLabel.snp.top).offset(-16)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(1)
            }
            
            bearFaceImage.snp.makeConstraints {
                $0.centerY.equalTo(memoLabel)
                $0.leading.equalToSuperview().inset(24)
                $0.width.equalTo(50)
                $0.height.equalTo(49)
            }
            
            memoLabel.snp.makeConstraints {
                $0.top.equalTo(selectDateLabel.snp.bottom).offset(36)
                $0.leading.equalTo(bearFaceImage.snp.trailing).offset(12)
                $0.trailing.equalToSuperview().inset(24)
            }
            
            selectDateMemoBottomDotView.snp.makeConstraints {
                $0.top.equalTo(memoHeight <= 49 ? bearFaceImage.snp.bottom : memoLabel.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(1)
            }
            
            achieveCollectionView.snp.makeConstraints {
                $0.top.equalTo(selectDateMemoBottomDotView.snp.bottom).offset(16)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth)
                $0.height.equalTo(height)
                $0.bottom.equalToSuperview().inset(20)
            }
        } else {
            achieveCollectionView.snp.makeConstraints {
                $0.top.equalTo(selectDateLabel.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth)
                $0.height.equalTo(height)
                $0.bottom.equalToSuperview().inset(20)
            }
        }
        
        addMemoButton.isHidden = isRecord
        memoGuideImage.isHidden = isRecord || UserManager.shared.getWriteMemo
    }
}
