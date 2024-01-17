//
//  HappinessMemberEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/16/24.
//

import Foundation

struct HappinessMemberEntity: Codable {
    let routineId: Int
    let iconImageUrl: String
    let contentImageUrl: String
    let themeName: String
    let themeNameColor: String
    var title: String
    var content: String
    var detailContent: String
    var place: String
    var timeTaken: String
}
