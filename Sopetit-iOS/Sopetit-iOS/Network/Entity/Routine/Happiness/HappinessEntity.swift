//
//  HappinessEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

struct HappinessEntity: Codable {
    var routines: [Happiness]
}

struct Happiness: Codable {
    let routineId: Int
    let name: String
    let nameColor: String
    let title: String
    let iconImageUrl: String

    enum CodingKeys: String, CodingKey {
        case routineId
        case name
        case nameColor
        case title
        case iconImageUrl
    }
}
