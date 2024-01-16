//
//  BottomSheetType.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/07.
//

import UIKit

enum BottomSheetType {
    case dailyAddBottom
    case happyAddBottom
    case dailyCompleteBottom
    case happyCompleteBottom
    case dailyDeleteBottom
    case happyDeleteBottom
    case logoutBottom
}

extension BottomSheetType {
    var image: UIImage {
        switch self {
        case .dailyAddBottom, .happyAddBottom, .dailyCompleteBottom, .happyCompleteBottom:
            return ImageLiterals.DailyRoutine.icDaily1Filled
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return ImageLiterals.BottomNavi.icFaceCrying
        }
    }
    
    var title: String {
        switch self {
        case .dailyAddBottom:
            return I18N.BottomSheet.dailyAddTitle
        case .happyAddBottom:
            return I18N.BottomSheet.happyAddTitle
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
        case .dailyAddBottom:
            return I18N.BottomSheet.dailyAddSubTitle
        case .dailyCompleteBottom, .happyCompleteBottom:
            return I18N.BottomSheet.delInfoTitle
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
        case .dailyAddBottom, .dailyCompleteBottom, .happyCompleteBottom:
            return .Gray400
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
        case .dailyAddBottom, .happyAddBottom:
            return I18N.BottomSheet.addLeftTitle
        case .dailyCompleteBottom, .happyCompleteBottom:
            return I18N.BottomSheet.dailyLeftTitle
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return I18N.BottomSheet.delLeftTitle
        }
    }
    
    var rightTitle: String {
        switch self {
        case .dailyAddBottom, .happyAddBottom:
            return I18N.BottomSheet.addRightTitle
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
        case .dailyAddBottom, .happyAddBottom, .dailyCompleteBottom, .happyCompleteBottom:
            return .SoftieMain1
        case .dailyDeleteBottom, .happyDeleteBottom, .logoutBottom:
            return .SoftieRed
        }
    }
}
