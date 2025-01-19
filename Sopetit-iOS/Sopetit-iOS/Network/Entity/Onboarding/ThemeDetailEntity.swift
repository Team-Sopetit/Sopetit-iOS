//
//  RoutineIDEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 7/4/24.
//

import UIKit

struct ThemeDetailEntity {
    let themeTitle: String
    let themeImage: UIImage
}

extension ThemeDetailEntity {
    
    static func getTheme(id: Int) -> ThemeDetailEntity {
        let titleList = ["관계 쌓기", 
                         "마음 챙김",
                         "통통한 통장",
                         "산뜻한 일상",
                         "한 걸음 성장",
                         "건강한 몸",
                         "나와 친해지기"]
        return ThemeDetailEntity(themeTitle: titleList[id-1],
                                 themeImage: UIImage(named: "theme\(id)") ?? UIImage())
    }
    
    static func getFullTheme(id: Int) -> ThemeDetailEntity {
        let titleList = ["관계 쌓기",
                         "마음 챙김",
                         "통통한 통장",
                         "산뜻한 일상",
                         "한 걸음 성장",
                         "건강한 몸",
                         "나와 친해지기"]
        if id == 0 {
            return ThemeDetailEntity(themeTitle: "기타",
                                     themeImage: UIImage(named: "theme_full_\(id)") ?? UIImage())
        } else {
            return ThemeDetailEntity(themeTitle: titleList[id-1],
                                     themeImage: UIImage(named: "theme_full_\(id)") ?? UIImage())
        }
    }
}
