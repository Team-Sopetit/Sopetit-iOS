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
    
    // MARK: - OnBoarding URL
    
    static let themeURL = baseURL + "/api/v1/routines/daily/themes"
    static let dollImageURL = baseURL + "/api/v1/dolls/image/"
    static let routineURL = baseURL + "/api/v1/routines/daily/theme/"
}
