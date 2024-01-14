//
//  RoutineChoiceEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import Foundation

struct RoutineChoiceEntity: Codable {
    let routines: [Routine]
}

struct Routine: Codable {
    let routineID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case content
    }
}
