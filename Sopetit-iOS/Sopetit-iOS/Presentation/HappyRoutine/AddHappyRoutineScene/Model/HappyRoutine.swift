//
//  HappyRoutine.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/10/24.
//

import UIKit

struct HappyRoutine {
    let title: String
    let subTitle: String
    let color: String
    let iconImage: UIImage
    var routines: [HappyRoutineDetail]
}

struct HappyRoutineDetail {
    let routineId: Int
    let cardImage: UIImage
    let content: String
    let detailTitle: String
    let detailContent: String
    let detailTime: String
    let detailPlace: String
}

extension HappyRoutine {
    
    static func dummy() -> HappyRoutine {
        return HappyRoutine(title: "관계 쌓기",
                            subTitle: "성숙한 사랑을 만나기 위한",
                            color: "#FF5D76",
                            iconImage: ImageLiterals.HappyRoutine.icHappyBlingRed,
                            routines: [HappyRoutineDetail(routineId: 0,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "11이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 1,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "22이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 2,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "33이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 3,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "44이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 4,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "55이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 5,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "66이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길"),
                                       HappyRoutineDetail(routineId: 6,
                                                          cardImage: ImageLiterals.HappyRoutine.imgHappycardText,
                                                          content: "서점에 가서 랜덤 책 골라서 맘에 드는 문장 적기",
                                                          detailTitle: "77이상형의 특성 10가지 적어보고,\n절대 포기하지 못할 2가지와\n나와 비슷한 3가지 찾아보기",
                                                          detailContent: "평소에 바빠서 연락하지 못한 사람이 있다면 안부인사 개인톡을 보내 봐. 꼭 만나서 밥을 먹거나 하지 않아도 연락 한 통이 나와 그 사람을 연결하는 방법이 될 수 있어",
                                                          detailTime: "5~10분",
                                                          detailPlace: "회사 옥상, 점심식사 후 돌아가는 길")]
        )
    }
}
