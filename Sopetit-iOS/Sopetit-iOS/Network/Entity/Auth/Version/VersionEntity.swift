//
//  VersionEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 1/31/24.
//

import Foundation

struct VersionEntity: Codable {
    let iosVersion, androidVersion: Version
    let notificationTitle, notificationContent: String
}

// MARK: - Version
struct Version: Codable {
    let appVersion, forceUpdateVersion: String
}
