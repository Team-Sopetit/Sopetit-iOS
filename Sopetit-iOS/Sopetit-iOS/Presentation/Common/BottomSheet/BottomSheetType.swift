//
//  BottomSheetType.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/07.
//

import UIKit

enum BottomSheetType {
    case dailyCompleteBottom
    case happyCompleteBottom
    case dailyDeleteBottom
    case happyDeleteBottom
    case logoutBottom
}

extension BottomSheetType {
    var image: UIImage {
        switch self {
        case .dailyCompleteBottom, .happyCompleteBottom:
            return ImageLiterals.DailyRoutine.icDaily1Filled
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return ImageLiterals.Onboarding.imgFaceBrown
        }
    }
    
    var title: String {
        switch self {
        case .dailyCompleteBottom:
            return I18N.BottomSheet.dailyTitle
        case .happyCompleteBottom:
            return I18N.BottomSheet.happyTitle
        case .dailyDeleteBottom, .happyDeleteBottom:
            return I18N.BottomSheet.delTitle
        case .logoutBottom:
            return I18N.BottomSheet.logoutTitle
        }
    }
    
    var subTitle: String {
        switch self {
        case .dailyDeleteBottom:
            return I18N.BottomSheet.delSubTitle
        case .logoutBottom:
            return I18N.BottomSheet.logoutSubTitle
        default:
            return I18N.BottomSheet.emptyTitle
        }
    }
    
    var subColor: UIColor {
        switch self {
        case .dailyDeleteBottom:
            return .SoftieRed
        case .logoutBottom:
            return .Gray300
        default:
            return .SoftieWhite
        }
    }
    
    var leftTitle: String {
        switch self {
        case .dailyCompleteBottom, .happyCompleteBottom:
            return I18N.BottomSheet.dailyLeftTitle
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return I18N.BottomSheet.delLeftTitle
        }
    }
    
    var rightTitle: String {
        switch self {
        case .dailyCompleteBottom, .happyCompleteBottom:
            return I18N.BottomSheet.dailyRightTitle
        case .dailyDeleteBottom, .happyDeleteBottom:
            return I18N.BottomSheet.delRightTitle
        case .logoutBottom:
            return I18N.BottomSheet.logoutRightTitle
        }
    }
    
    var rightColor: UIColor {
        switch self {
        case .dailyCompleteBottom, .happyCompleteBottom:
            return .SoftieMain1
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return .SoftieRed
        }
    }
}
