//
//  HappinessRoutineEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/16/24.
//

import Foundation

struct HappinessRoutineEntity: Codable {
    let title: String
    let name: String
    let nameColor: String
    let iconImageUrl: String
    let contentImageUrl: String
    var subRoutines: [SubRoutine]
}

struct SubRoutine: Codable {
    let subRoutineId: Int
    let content: String
    let detailContent: String
    let timeTaken: String
    let place: String
    
    enum CodingKeys: String, CodingKey {
        case subRoutineId
        case content
        case detailContent
        case timeTaken
        case place
    }
}
