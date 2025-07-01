//
//  StringLiterals.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

enum I18N {
    enum BottomSheet {
        static let dailyAddTitle = "데일리 루틴을 추가할까요?"
        static let happyAddTitle = "행복 루틴을 추가할까요?"
        static let dailyAddSubTitle = "\'일어나면 5분 안에 이불 개기\'"
        static let dailyTitle = "데일리 루틴을 완료했나요?"
        static let happyTitle = "행복 루틴을 완료했나요?"
        static let delTitle = "정말 삭제할까요?"
        static let logoutTitle = "정말 로그아웃 할까요?"
        static let delInfoTitle = "한 번 완료하면 이전으로 되돌릴 수 없어요"
        static let emptyTitle = ""
        static let delSubTitle = "루틴을 삭제해도 달성 횟수는 저장돼요"
        static let logoutSubTitle = "\"잠시 안녕.. 다음에 또 봐!\""
        static let dailyLeftTitle = "아니, 아직이야"
        static let delLeftTitle = "취소"
        static let dailyRightTitle = "완료했어"
        static let delRightTitle = "삭제할래"
        static let logoutRightTitle = "로그아웃 할래"
        static let addLeftTitle = "아니, 더 고민할게"
        static let addRightTitle = "추가할래"
    }
    
    enum UpdateAlert {
        static let forceUpdateButtonTitle = "업데이트 하러가기"
        static let recommendUpdateButtonTitle = "업데이트"
        static let recommendBackButtonTitle = "다음에 할래요"
    }
    
    enum Splash {
        static let mentTitle = "하루를 바꾸는 가장 사소한 루틴"
    }
    
    enum Onboarding {
        static let firtButtonTitle = "오늘도 고된 하루였어.."
        static let secondButtonTitle = "어? 집 앞에 이건 뭐지?"
        static let thirdButtonTitle = "한 번 열어볼까?"
        static let dollChoiceTitle = "어떤 친구와 함께 할까요?"
        static let dollSubTitle = "한 번 선택한 인형은 바꿀 수 없어요"
        static let buttonTitle = "이 친구와 함께 할래"
        static let themeButtonTitle = "다 선택했어"
        static let themeTitle = "내가 원하는 모습을 선택해봐!\n처음엔 3개만 선택할 수 있어"
        static let routineChoiceTitle = "처음에는 작고 가볍게 시작하기 위해\n3개의 루틴만 선택할 수 있어!"
        static let routineBackButtonTitle = "루틴을 3개 선택해 주세요"
        static let routineNextButtonTitle = "친구 만날 준비 끝!"
        static let dollNameTitle = "좋은 선택이에요!\n친구 이름도 지어볼까요?"
        static let dollNameSubTitle = "한 번 지은 이름은 이후에 수정이 어려워요"
        static let textfieldPlaceholder = "소프티"
        static let dollNameInfoTitle = "*숫자와 특수문자는 사용할 수 없어요"
        static let dollNameInfoTitle2 = "*10글자 이내로 작성해 주세요."
        static let dollNameButtonTitle = "이 이름이 좋겠어"
        static let dollSpecialText = "-!@#$%^&*()_+={}[]₩|\\n;:'\",.<>?/~`£¥• "
        static let toastTitle = "3개만 선택할 수 있어요"
    }
    
    enum HappyRoutine {
        static let happyRoutineTitle = "행복 루틴"
        static let bearBubble = "행복 루틴은 행복한 나를 매일\n조금씩 만들어 가는 특별한 루틴이야"
        static let addRoutine = "진행 중인 행복루틴이 없어요.\n루틴을 추가할까요?"
        static let addHappyRoutineTitle = "행복 루틴 추가"
        static let addHappyRoutineButton = "이 루틴을 추가할래"
        static let achieving = "달성 중..."
        static let done = "완료하기"
        static let delAlertTitle = "행복 루틴을 삭제했어요"
        static let addHappyBottomTitle = "행복 루틴을 추가했어요"
        static let completeHappyRoutine = "행복 루틴을 완료했어요!"
        static let getCotton = "행복 솜뭉치 1개 획득"
        static let deleteRoutine = "달성 중인 루틴 삭제"
    }
    
    enum HappyRoutineCategory {
        static let all = "전체"
        static let relationship = "관계 쌓기"
        static let aStep = "한 걸음 성장"
        static let rest = "잘 쉬어가기"
        static let new = "새로운 나"
        static let mind = "마음 챙김"
    }
    
    enum CustomNavi {
        static let cancel = "취소"
        static let edit = "편집"
        static let delete = "삭제"
    }
    
    enum Login {
        static let bubbleTitle = "날 꺼내줘!"
        static let kakaoLoginTitle = "카카오로 시작하기"
        static let appleLoginTitle = "Apple로 시작하기"
    }
    
    enum Home {
        static let actionTitle1 = "솜뭉치 주기"
        static let actionTitle2 = "무지개 솜뭉치 주기"
        static let moneyNotion = "https://softie-link.notion.site/92fc58e36cf448eca66ee47e1c50bee8?pvs=4"
        static let cottonTitle = "냠냠"
    }
    
    enum TabBar {
        static let ongoing = "진행 중"
        static let home = "홈"
        static let achieve = "달성도"
    }
    
    enum Setting {
        static let settingTitle = "설정"
        static let withdraw = "정말 가는거야..? 나는 영영 사라져..."
        static let withdraw_head = "탈퇴하면 계정이 삭제되고 모든 데이터가 사라집니다."
        static let personalTitle = "개인정보 처리방침"
        static let serviceTitle = "서비스 이용 약관"
        static let feedbackTitle = "여러분의 의견이 필요해요!"
        static let versionTitle = "현재 버전 1.0.0"
        static let logoutTItle = "로그아웃"
        static let withdrawTitle = "회원 탈퇴"
        static let personalNotion = "https://softie-link.notion.site/c2435b30cfdb45db82f91cae6d1cc789?pvs=4"
        static let serviceNotion = "https://softie-link.notion.site/b8b8c02805924f2ababd4de7b2306d64?pvs=4"
        static let feedbackFoam = "https://forms.gle/98DLaYEv3ABYv9FF7"
    }
    
    enum SessionExpiredAlert {
        static let title = "인증 세션이 만료되었습니다."
        static let message = "원활한 앱 사용을 위해\n다시 로그인 해주세요."
    }
    
    enum Ongoing {
        static let ongoingReadyTitle = "달성도는 준비 중이에요\n곧 만나요!"
    }
    
    enum ActiveRoutine {
        static let challengeTitle = "하루에 한 번, 오늘의 도전!"
        static let dailyTitle = "매일 매일, 데일리 루틴"
        static let complete = "완료하기"
        static let addChallenge = "챌린지를 추가해 볼까요?"
        static let addChallengeButton = "루틴 추가하기"
        static let emptyRoutine = "진행 중인 루틴이 없어요"
        static let emptyDaily = "데일리 루틴을 추가해 볼까요?"
    }
}
