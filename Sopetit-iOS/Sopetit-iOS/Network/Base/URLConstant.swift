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
    
    // MARK: - OnBoarding URL
    
    static let themeURL = baseURL + "/api/v1/routines/daily/themes"
    static let dollImageURL = baseURL + "/api/v1/dolls/image/"
    static let routineURL = baseURL + "/api/v1/routines/daily/theme/"
    
    static let happinessThemesURL = baseURL + "/api/v1/routines/happiness/themes"
    static let happinessURL = baseURL + "/api/v1/routines/happiness"
    static let happinessRoutineURL = baseURL + "/api/v1/routines/happiness/routine/"
    static let happinessMemberURL = baseURL + "/api/v1/routines/happiness/member"
    static let happinessMemberRoutineURL = baseURL + "/api/v1/routines/happiness/member/routine/"
}
