//
//  HappyRoutineCategory.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/10/24.
//

import UIKit

struct HappyRoutineCategory {
    let routineID: Int
    let title: String
    let content: String
    let image: UIImage
    let color: String
}

extension HappyRoutineCategory {
    
    static func dummy() -> [HappyRoutineCategory] {
        return [HappyRoutineCategory(routineID: 0,
                                     title: "관계 쌓기",
                                     content: "성숙한 사랑을 만나기 위한",
                                     image: ImageLiterals.HappyRoutine.icHappyRed,
                                     color: "#FF5D76"),
                HappyRoutineCategory(routineID: 1,
                                     title: "관계 쌓기",
                                     content: "진정성 있는 관계를 만드는",
                                     image: ImageLiterals.HappyRoutine.icHappyRed,
                                     color: "#FF5D76"),
                HappyRoutineCategory(routineID: 2,
                                     title: "한 걸음 성장",
                                     content: "좋아하는, 잘하는 일을 찾아 가는",
                                     image: ImageLiterals.HappyRoutine.icHappyOrange,
                                     color: "#F27400"),
                HappyRoutineCategory(routineID: 3,
                                     title: "한 걸음 성장",
                                     content: "좋아하는, 잘하는 일을 찾아 가는",
                                     image: ImageLiterals.HappyRoutine.icHappyOrange,
                                     color: "#F27400"),
                HappyRoutineCategory(routineID: 4,
                                     title: "잘 쉬어가기",
                                     content: "데이터가 아직 없습니다",
                                     image: ImageLiterals.HappyRoutine.icHappyGreen,
                                     color: "#3DB96F"),
                HappyRoutineCategory(routineID: 5,
                                     title: "새로운 나",
                                     content: "나를 알고 진짜 목표를 세우는",
                                     image: ImageLiterals.HappyRoutine.icHappyBlue,
                                     color: "#7B89D1"),
                HappyRoutineCategory(routineID: 6,
                                     title: "마음 챙김",
                                     content: "데이터가 아직 없습니다",
                                     image: ImageLiterals.HappyRoutine.icHappyPurple,
                                     color: "#BC73E6")]
    }
}
