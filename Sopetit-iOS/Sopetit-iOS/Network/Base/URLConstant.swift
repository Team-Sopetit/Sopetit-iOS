//
//  URLConstant.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

enum URLConstant {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // MARK: - Auth URL
    
    static let loginURL = baseURL + "/api/v1/auth"
    static let logoutURL = baseURL + "/api/v1/auth/logout"
    static let resignURL = baseURL + "/api/v1/auth"
    static let reissueURL = baseURL + "/api/v1/auth/token"
    static let versionURL = baseURL + "/api/v1/versions/client/app"
    
    // MARK: - OnBoarding URL
    
    static let themeURL = baseURL + "/api/v2/themes"
    static let dollImageURL = baseURL + "/api/v1/dolls/image/"
    static let routineURL = baseURL + "/api/v2/routines/daily?themeIds="
    static let memberURL = baseURL + "/api/v1/members"
    
    // MARK: - Home URL
    
    static let homeURL = baseURL + "/api/v1/members"
    static let cottonURL = baseURL + "/api/v1/members/cotton/"
    
    // MARK: - DailyRoutine URL
    
    static let dailyMemberURL = baseURL + "/api/v1/routines/daily/member"
    static let postRoutineURL = baseURL + "/api/v1/routines/daily/member/"
    static let patchRoutineURL = baseURL + "/api/v1/routines/daily/member/routine/"
    static let dailyThemesURL = baseURL + "/api/v1/routines/daily/themes"
    static let dailyThemeRoutineURL = baseURL + "/api/v1/routines/daily/theme/"
    
    static let v2DailyMemberURL = baseURL + "/api/v2/routines/daily/member"
    static let v2ChallengeURL = baseURL + "/api/v2/routines/challenge/member"
    
    // MARK: - HappyRoutine URL
    
    static let happinessThemesURL = baseURL + "/api/v1/routines/happiness/themes"
    static let happinessURL = baseURL + "/api/v1/routines/happiness"
    static let happinessRoutineURL = baseURL + "/api/v1/routines/happiness/routine/"
    static let happinessMemberURL = baseURL + "/api/v1/routines/happiness/member"
    static let happinessMemberRoutineURL = baseURL + "/api/v1/routines/happiness/member/routine/"
    
    // MARK: - AddRoutine URL
    
    static let dailyThemeURL = baseURL + "/api/v2/routines/daily/theme/"
    static let challengeThemeURL = baseURL + "/api/v2/challenges?themeId="
//    static let challengeMemberURL = baseURL + "/api/v2/routines/challenge/member"
    static let addDailyMemberURL = baseURL + "/api/v2/routines/daily/member"
    static let challengeMemberURL = baseURL + "/api/v2/members/challenges"
    static let challengeAchievementURL = baseURL + "/api/v2/members/challenges/achievement"
    
    // MARK: - Achieve URL
    
    static let membersProfileURL = baseURL + "/api/v1/members/profile"
    static let memosURL = baseURL + "/api/v3/memos"
    static let memosWithIdURL = baseURL + "/api/v3/memos/"
    static let calendarURL = baseURL + "/api/v3/calendar"
    static let delDailyHistoryURL = baseURL + "/api/v1/routines/daily/member/history/"
    static let delChallengeHistoryURL = baseURL + "/api/v2/members/challenges/history/"
    static let achievementThemesURL = baseURL + "/api/v3/achievement/themes"
    static let achievementThemesRoutinesURL = baseURL + "/api/v3/achievement/themes/"
}
