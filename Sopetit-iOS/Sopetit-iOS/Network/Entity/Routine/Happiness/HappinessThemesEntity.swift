//
//  HappinessThemesEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/15/24.
//

import Foundation

struct HappinessThemesEntity: Codable {
    var themes: [HappinessTheme]
}

struct HappinessTheme: Codable {
    let themeId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case themeId
        case name
    }
}
