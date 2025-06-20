//
//  EditDailyRoutineInfo.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 6/16/25.
//

struct EditDailyRoutineInfo {
    let routineId: Int
    let themeId: Int
    let content: String
    let alarmTime: String?
    let isSoftieRoutine: Bool
}

extension EditDailyRoutineInfo {
    static let initInfo = EditDailyRoutineInfo(
        routineId: 0,
        themeId: 0,
        content: "",
        alarmTime: nil,
        isSoftieRoutine: false
    )
}
