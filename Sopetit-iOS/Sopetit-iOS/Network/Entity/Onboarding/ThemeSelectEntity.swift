//
//  ThemeSelectEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import Foundation

struct ThemeSelectEntity: Codable {
    let themes: [Theme]
}

struct Theme: Codable {
    let themeID: Int
    let name: String
    let iconImageURL, backgroundImageURL: String

    enum CodingKeys: String, CodingKey {
        case themeID = "themeId"
        case name
        case iconImageURL = "iconImageUrl"
        case backgroundImageURL = "backgroundImageUrl"
    }
}

extension ThemeSelectEntity {
    static func themeDummy() -> ThemeSelectEntity {
        return ThemeSelectEntity(
            themes: [Theme(themeID: 0, name: "하루의 시작", iconImageURL: "ic_daily_1_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 1, name: "건강한 몸", iconImageURL: "ic_daily_2_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 2, name: "무기력 극복", iconImageURL: "ic_daily_3_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 3, name: "편안한 잠", iconImageURL: "ic_daily_4_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 4, name: "환경지킴이", iconImageURL: "ic_daily_5_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 5, name: "소소한 친절", iconImageURL: "ic_daily_6_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 6, name: "감사의 마음", iconImageURL: "ic_daily_7_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 7, name: "작은 성취감", iconImageURL: "ic_daily_8_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 8, name: "소중한 나", iconImageURL: "ic_daily_9_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 9, name: "통통한 통장", iconImageURL: "ic_daily_10_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 10, name: "몰입할 준비", iconImageURL: "ic_daily_11_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1"), Theme(themeID: 11, name: "비워내기", iconImageURL: "ic_daily_12_filled", backgroundImageURL: "ImageLiterals.Onboarding.imgSpotlight1")])
    }
}
