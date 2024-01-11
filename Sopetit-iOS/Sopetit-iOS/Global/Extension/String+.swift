//
//  String+.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

extension String {
    var containsEmoji: Bool {
        for scalar in unicodeScalars where scalar.properties.isEmoji {
            return true
        }
        return false
    }
    
    func isOnlyKorean() -> Bool {
        let pattern = "^[가-힣]*$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
}
