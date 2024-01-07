//
//  ImageLiterals.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

enum ImageLiterals {
    enum Common {
        static var logo: UIImage { .load(name: "softieLogo") }
    }
    
    enum Onboarding {
        static var imgGirl1: UIImage { .load(name: "img_girl_1") }
        static var imgGirl2: UIImage { .load(name: "img_girl_2") }
        static var imgDoor: UIImage { .load(name: "img_door") }
        static var bearBrownUp: UIImage { .load(name: "bear_brown_up") }
        static var bearBrownDown: UIImage { .load(name: "bear_brown_down") }
        static var bearGrayUp: UIImage { .load(name: "bear_gray_up") }
        static var bearGrayDown: UIImage { .load(name: "bear_gray_down") }
        static var bearPandaUp: UIImage { .load(name: "bear_panda_up") }
        static var bearPandaDown: UIImage { .load(name: "bear_panda_down") }
        static var bearRedUp: UIImage { .load(name: "bear_red_up") }
        static var bearRedDown: UIImage { .load(name: "bear_red_down") }
        static var imgBoxClosed: UIImage { .load(name: "img_box_closed") }
        static var imgFaceBrown: UIImage { .load(name: "img_face_brown") }
        static var svgSpeechLong: UIImage { .load(name: "svg_speech_long") }
    }
}
