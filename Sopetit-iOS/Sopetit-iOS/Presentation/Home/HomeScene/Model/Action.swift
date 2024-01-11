//
//  Action.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/11/24.
//

import UIKit

struct Action {
    let action: String
    let count: Int
}

extension Action {
    
    static func dummy() -> [Action] {
        return [
            Action(action: "솜뭉치 주기", count: 99),
            Action(action: "행복 솜뭉치 주기", count: 3),
        ]
    }
}
