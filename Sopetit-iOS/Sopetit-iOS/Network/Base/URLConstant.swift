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
    static let logoutURL = baseURL + "/api/v1/members/logout"
    static let resignURL = baseURL + "/api/v1/members"
    
    // MARK: - OnBoarding URL
    
    static let themeURL = baseURL + "/api/v1/routines/daily/themes"
    static let dollImageURL = baseURL + "/api/v1/dolls/image/"
    static let routineURL = baseURL + "/api/v1/routines/daily/theme/"
    
    // MARK: - Home URL
    
    static let homeURL = baseURL + "/api/v1/members"
    static let memberURL = baseURL + "/api/v1/members"
    
    // MARK: - DailyRoutine URL
    
    static let dailyURL = baseURL + "/api/v1/routines/daily/member"
    static let dailyThemesURL = baseURL + "/api/v1/routines/daily/themes"
    static let routinesDailyURL = baseURL + "/api/v1/routines/daily"
    static let routinesDailyMemberURL = baseURL + "/api/v1/routines/daily/member"
    
    // MARK: - HappyRoutine URL
    static let happinessThemesURL = baseURL + "/api/v1/routines/happiness/themes"
    static let happinessURL = baseURL + "/api/v1/routines/happiness"
    static let happinessRoutineURL = baseURL + "/api/v1/routines/happiness/routine/"
    static let happinessMemberURL = baseURL + "/api/v1/routines/happiness/member"
    static let happinessMemberRoutineURL = baseURL + "/api/v1/routines/happiness/member/routine/"
}
