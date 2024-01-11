//
//
//  Created by Woo Jye Lee on 1/2/24.
//

import Foundation

struct DailyEntity {
    let dateLabel: String
    let routineLabel: String
    let imageName: String
}

extension DailyEntity {
    static func routineDummy() -> [DailyEntity] {
        return [
            DailyEntity(dateLabel: "5", routineLabel: "이불 개기", imageName: "apple.logo"),
            DailyEntity(dateLabel: "5", routineLabel: "이불 개기", imageName: "apple.logo")
        ]
    }
}
