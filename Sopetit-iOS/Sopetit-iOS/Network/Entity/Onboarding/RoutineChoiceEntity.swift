//
//  RoutineChoiceEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import Foundation

struct RoutineChoiceEntity: Codable {
    let themes: [RoutineTheme]
}

struct RoutineTheme: Codable {
    let routineID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case content
    }
}

extension RoutineChoiceEntity {
    static func routineDummy() -> RoutineChoiceEntity {
        return RoutineChoiceEntity(
            themes: [RoutineTheme(routineID: 1, content: "하루 한 끼 건강식으로 먹기"),
                     RoutineTheme(routineID: 2, content: "앉아 있을 때 의식적으로 바른 자세 하기"),
                     RoutineTheme(routineID: 3, content: "잠자기 전에 오늘 다시 침대에\n누울 수 있음에 감사하기"),
                     RoutineTheme(routineID: 4, content: "하루 한 번 엘레베이터 대신 계단 이용하기"),
                     RoutineTheme(routineID: 5, content: "할일 전에 그 일을 잘 하면\n얻을 수 있는 구체적인 것 하나 적기"),
                     RoutineTheme(routineID: 6, content: "내려야 할 정거장 하나 먼저 내려서 걷기"),
                     RoutineTheme(routineID: 7, content: "오늘 감정이 담긴 일기 한줄 이상 쓰기"),
                     RoutineTheme(routineID: 8, content: "할일 전에 그 일을 잘 하면\n얻을 수 있는 구체적인 것 하나 적기"),
                     RoutineTheme(routineID: 9, content: "내려야 할 정거장 하나 먼저 내려서 걷기"),
                     RoutineTheme(routineID: 10, content: "오늘 감정이 담긴 일기 한줄 이상 쓰기")])
    }
}
