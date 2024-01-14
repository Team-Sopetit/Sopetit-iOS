//
//  DollImageEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/14.
//

import Foundation

struct DollImageEntity: Codable {
    let faceImageURL: String

    enum CodingKeys: String, CodingKey {
        case faceImageURL = "faceImageUrl"
    }
}
