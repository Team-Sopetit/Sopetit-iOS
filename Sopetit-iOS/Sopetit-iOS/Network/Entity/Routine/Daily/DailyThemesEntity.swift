//
//  DailyThemes.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/17/24.
//

import Foundation

struct DailyThemesEntity: Codable {
    var themes: [DailyTheme]
}

struct DailyTheme: Codable {
    let themeId: Int
    let name: String
    let iconImageUrl: String
    let backgroundImageUrl: String
}
