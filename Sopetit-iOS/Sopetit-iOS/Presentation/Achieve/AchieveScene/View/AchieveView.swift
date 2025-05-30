//
//  AchieveView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class AchieveView: UIView {
    
    // MARK: - UI Components
    
    let achieveMenuView = AchieveMenuView()
    let achieveCalendarView = AchieveCalendarView()
    let achieveStatsView = AchieveStatsView()
    
    let delMemoToast = ToastWithCheckView(toastContent: "메모를 삭제했어요")
    let editMemoToast = ToastWithCheckView(toastContent: "메모를 수정했어요")
    let delDailyHistoryToast = ToastWithCheckView(toastContent: "데일리루틴 기록을 삭제했어요")
    let delChallengeHistoryToast = ToastWithCheckView(toastContent: "도전루틴 기록을 삭제했어요")
    let addMemoToast = ToastWithCottonView(toastContent: "하루를 메모했어요")
    
    // MARK: - Life Cycles
    
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

// MARK: - Extensions

private extension AchieveView {
    
    func setUI() {
        self.backgroundColor = .Gray50
        [delMemoToast, editMemoToast, delDailyHistoryToast, delChallengeHistoryToast, achieveCalendarView, addMemoToast].forEach {
            $0.isHidden = true
        }
    }
    
    func setHierarchy() {
        addSubviews(achieveMenuView,
                    achieveCalendarView,
                    achieveStatsView,
                    delMemoToast,
                    editMemoToast,
                    delDailyHistoryToast,
                    delChallengeHistoryToast,
                    addMemoToast)
    }
    
    func setLayout() {
        achieveMenuView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        achieveCalendarView.snp.makeConstraints {
            $0.top.equalTo(achieveMenuView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        achieveStatsView.snp.makeConstraints {
            $0.top.equalTo(achieveMenuView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        delMemoToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        editMemoToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        delDailyHistoryToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        delChallengeHistoryToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        addMemoToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
    }
}
