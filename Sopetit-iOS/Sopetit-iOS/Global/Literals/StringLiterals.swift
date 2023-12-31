//
//  StringLiterals.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

enum I18N {
    enum BottomSheet {
        static let dailyTitle = "데일리 루틴을 완료했나요?"
        static let happyTitle = "행복 루틴을 완료했나요?"
        static let delTitle = "정말 삭제할까요?"
        static let logoutTitle = "정말 로그아웃 할까요?"
        static let emptyTitle = ""
        static let delSubTitle = "루틴을 삭제해도 달성 횟수는 저장돼요"
        static let logoutSubTitle = "\"잠시 안녕.. 다음에 또 봐!\""
        static let dailyLeftTitle = "아니, 아직이야"
        static let delLeftTitle = "취소"
        static let dailyRightTitle = "완료했어"
        static let delRightTitle = "삭제할래"
        static let logoutRightTitle = "로그아웃 할래"
    }
    
    enum Onboarding {
        static let firtButtonTitle = "오늘도 고된 하루였어.."
        static let secondButtonTitle = "어? 집 앞에 이건 뭐지?"
        static let thirdButtonTitle = "한 번 열어볼까?"
        static let dollChoiceTitle = "어떤 친구와 함께 할까요?"
        static let dollSubTitle = "한 번 선택한 인형은 바꿀 수 없어요"
        static let buttonTitle = "이 친구와 함께 할래"
    }
    
    enum HappyRoutine {
        static let happyRoutineTitle = "행복 루틴"
        static let bearBubble = "행복루틴은 매일 조금씩 너에 대해\n알아갈 수 있는 특별한 루틴이야!"
        static let addRoutine = "진행 중인 행복루틴이 없어요.\n루틴을 추가할까요?"
    }
    
    enum CustomNavi {
        static let cancel = "취소"
        static let edit = "편집"
    }
    
    enum Login {
        static let bubbleTitle = "회원가입하고 봉인해제"
        static let kakaoLoginTitle = "카카오로 시작하기"
        static let appleLoginTitle = "Apple로 시작하기"
    }
}
