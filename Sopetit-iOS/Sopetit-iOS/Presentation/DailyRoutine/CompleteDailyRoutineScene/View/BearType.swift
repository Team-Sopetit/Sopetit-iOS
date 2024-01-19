//
//  BearType.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/19.
//

import UIKit

enum BearType {
    case BROWN, RED, WHITE, GRAY
    
    var dailyCompleteBear: UIImage {
        switch self {
        case .BROWN:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteBrown
        case .RED:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteRed
        case .WHITE:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompletePanda
        case .GRAY:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteGray
        }
    }
    
    var happyCompleteBear: UIImage {
        switch self {
        case .BROWN:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearBrown
        case .RED:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearRed
        case .WHITE:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearPanda
        case .GRAY:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearGray
        }
    }
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "brown":
            self = .BROWN
        case "red":
            self = .RED
        case "white":
            self = .WHITE
        case "gray":
            self = .GRAY
        default:
            return nil
        }
    }
}
