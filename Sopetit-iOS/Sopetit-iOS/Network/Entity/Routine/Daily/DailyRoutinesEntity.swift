//
//  DailyRoutinesEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/17/24.
//

import Foundation

struct DailyRoutinesEntity: Codable {
    let backgroundImageUrl: String
    var routines: [DailyRoutine]
}

struct DailyRoutine: Codable {
    let routineId: Int
    let content: String
}
