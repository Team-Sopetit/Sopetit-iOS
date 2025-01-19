//
//  AchieveRankEntity.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/10/25.
//

import UIKit

struct AchieveRankEntity {
    let themeId: Int
    let percent: Int
}

extension AchieveRankEntity {
    
    static func initalEntity() -> [AchieveRankEntity] {
        return [AchieveRankEntity(themeId: 0, percent: 0)]
    }
}
