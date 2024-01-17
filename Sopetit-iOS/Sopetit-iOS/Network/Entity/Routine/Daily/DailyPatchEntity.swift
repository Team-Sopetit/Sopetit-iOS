//
//  DailyPatchEntity.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/17/24.
//

import Foundation

struct DailyPatchEntity: Codable {
    let routineID: Int
    let isAchieve: Bool
    let achieveCount: Int

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case isAchieve, achieveCount
    }
}
