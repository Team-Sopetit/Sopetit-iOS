//
//  AchieveThemeEntity.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/10/25.
//

struct AchieveThemeEntity: Codable {
    let achievedCount: Int
    let themes: [AchieveTheme]
}

// MARK: - AchieveTheme
struct AchieveTheme: Codable {
    let id: Int
    let name: String
    let achievedCount: Int
}

extension AchieveThemeEntity {
    
    static func initalEntity() -> AchieveThemeEntity {
        return AchieveThemeEntity(achievedCount: 0, themes: [])
    }
}
