//
//  FontLiterals.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

enum FontName: String {
    case PretendardMedium = "Pretendard-Medium"
    case PretendardSemiBold = "Pretendard-SemiBold"
}

enum FontLevel {
    case head1
    case head2
    case head3
    case head4
    
    case body1
    case body2
    case body3
    case body4
    
    case caption1
    case caption2
    case caption3
    case caption4
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .head1, .head3, .body1, .body3, .caption1, .caption3:
            return FontName.PretendardSemiBold.rawValue
        case .head2, .head4, .body2, .body4, .caption2, .caption4:
            return FontName.PretendardMedium.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .head1, .head2:
            return 20
        case .head3, .head4:
            return 18
        case .body1, .body2:
            return 16
        case .body3, .body4:
            return 14
        case .caption1, .caption2:
            return 12
        case .caption3, .caption4:
            return 10
        }
    }
}

extension UIFont {
    static func fontGuide(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
