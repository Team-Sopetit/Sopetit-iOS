//
//
//  Created by Woo Jye Lee on 1/2/24.
//

import Foundation

//struct DailyEntity {
//    let dateLabel: String
//    let routineLabel: String
//    let imageName: String
//}
//
//extension DailyEntity {
//    static func routineDummy() -> [DailyEntity] {
//        return [
//            DailyEntity(dateLabel: "5", routineLabel: "이불 개기", imageName: "apple.logo"),
//            DailyEntity(dateLabel: "5", routineLabel: "이불 개기", imageName: "apple.logo")
//        ]
//    }
//}

// MARK: - DailyEntity
struct DailyEntity: Codable {
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let routines: [Routine1]
}

// MARK: - Routine
struct Routine1: Codable {
    let routineID: Int
    let content: String
    let iconImageURL: String
    let achieveCount: Int
    let isAchieve: Bool

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case content
        case iconImageURL = "iconImageUrl"
        case achieveCount, isAchieve
    }
}
