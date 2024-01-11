//
//  HappyRoutineCard.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/11/24.
//

import UIKit

struct HappyRoutineCard {
    let routineId: Int
    let cardImage: UIImage
    let title: String
    let content: String
    let detailTitle: String
    let detailContent: String
    let detailTime: String
    let detailPlace: String
}

extension HappyRoutineCard {
    
    static func dummy() -> HappyRoutineCard {
        return HappyRoutineCard(routineId: 0,
                                cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                title: "성숙한 사랑을 만나기 위한",
                                content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                detailTitle: "11이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                detailTime: "5~10분",
                                detailPlace: "회사 옥상, 점심식사 후 돌아가는 길")
    }
}
