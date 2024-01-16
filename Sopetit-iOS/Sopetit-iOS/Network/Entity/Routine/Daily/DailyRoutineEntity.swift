//
//
//  Created by Woo Jye Lee on 1/2/24.
//

import Foundation

struct DailyRoutineEntity: Codable {
    var routines: [DailyRoutines]
}

struct DailyRoutines: Codable {
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
