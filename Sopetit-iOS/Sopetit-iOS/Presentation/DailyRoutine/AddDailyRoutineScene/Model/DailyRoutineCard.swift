//
//  DailyRoutineCard.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

struct DailyRoutineCard {
    let routineId: Int
    let content: String
}

extension DailyRoutineCard {
    
    static func dummy() -> [DailyRoutineCard] {
        return [DailyRoutineCard(routineId: 0, content: "1일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 1, content: "2일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 2, content: "3일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 3, content: "4일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 4, content: "5일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 5, content: "6일어나면\n5분 안에 이불 개기"),
                DailyRoutineCard(routineId: 6, content: "7일어나면\n5분 안에 이불 개기")]
    }
}
