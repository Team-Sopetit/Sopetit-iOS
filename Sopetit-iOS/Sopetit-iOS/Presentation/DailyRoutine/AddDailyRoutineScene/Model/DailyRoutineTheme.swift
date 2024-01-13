//
//  DailyRoutineTheme.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

struct DailyRoutineTheme {
    let themeId: Int
    let name: String
    let iconImage: UIImage
    let cardImage: UIImage
}

extension DailyRoutineTheme {
    
    static func dummy() -> [DailyRoutineTheme] {
        return [DailyRoutineTheme(themeId: 0,
                                  name: "하루의 시작",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily1Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard1),
                DailyRoutineTheme(themeId: 1,
                                  name: "건강한 몸",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily2Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard2),
                DailyRoutineTheme(themeId: 2,
                                  name: "무기력 극복",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily3Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard3),
                DailyRoutineTheme(themeId: 3,
                                  name: "편안한 잠",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily4Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard4),
                DailyRoutineTheme(themeId: 4,
                                  name: "환경지킴이",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily5Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard5),
                DailyRoutineTheme(themeId: 5,
                                  name: "소소한 친절",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily6Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard6),
                DailyRoutineTheme(themeId: 6,
                                  name: "감사의 마음",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily7Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard7),
                DailyRoutineTheme(themeId: 7,
                                  name: "작은 성취감",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily8Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard8),
                DailyRoutineTheme(themeId: 8,
                                  name: "소중한 나",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily9Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard9),
                DailyRoutineTheme(themeId: 9,
                                  name: "통통한 통장",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily10Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard10),
                DailyRoutineTheme(themeId: 10,
                                  name: "몰입할 준비",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily11Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard11),
                DailyRoutineTheme(themeId: 11,
                                  name: "비워내기",
                                  iconImage: ImageLiterals.DailyRoutine.icDaily12Filled,
                                  cardImage: ImageLiterals.DailyRoutine.imgDailycard12),
        ]
    }
}
