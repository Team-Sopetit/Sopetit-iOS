//
//  HomeEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

struct HomeEntity: Codable {
    let attentionImageURL, backGroundImageURL: String
    let name, conversation, dollType: String
    let cottonCount, happinessCottonCount: Int

    enum CodingKeys: String, CodingKey {
        case attentionImageURL = "attentionImageUrl"
        case backGroundImageURL = "backGroundImageUrl"
        case name, conversation, dollType, cottonCount, happinessCottonCount
    }
}

extension HomeEntity {
    
    static func dummy() -> HomeEntity {
        return HomeEntity(attentionImageURL: "apple.logo", backGroundImageURL: "apple.logo", name: "반달가슴곰", conversation: "오늘 하루는 어땠어?\n나한테 얘기해주라!", dollType: "BROWN", cottonCount: 99, happinessCottonCount: 3)
    }
}
