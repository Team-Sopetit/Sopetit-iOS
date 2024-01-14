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
    
    enum BottomNavi {
        static var icNavi1: UIImage { .load(name: "ic_navi_1") }
        static var icNavi1Filled: UIImage { .load(name: "ic_navi_1_filled") }
        static var icNavi2: UIImage { .load(name: "ic_navi_2") }
        static var icNavi2Filled: UIImage { .load(name: "ic_navi_2_filled") }
        static var icNavi3: UIImage { .load(name: "ic_navi_3") }
        static var icNavi3Filled: UIImage { .load(name: "ic_navi_3_filled") }
        static var icFaceCrying: UIImage { .load(name: "img_face_crying") }
    }
    
    enum Navi {
        static var icChevronBack: UIImage { .load(name: "ic_chevron_back") }
    }
    
    enum Login {
        static var icLogoLogin: UIImage { .load(name: "ic_logo_login") }
        static var imgSpeechDark: UIImage { .load(name: "img_speech_dark") }
        static var icApple: UIImage { .load(name: "ic_apple") }
        static var icKakao: UIImage { .load(name: "ic_Kakao") }
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
        static var icOnboardNext: UIImage { .load(name: "ic_onboard_next") }
        static var imgSpotlight1: UIImage { .load(name: "img_spotlight1") }
        static var imgSpotlight2: UIImage { .load(name: "img_spotlight2") }
        static var imgSpotlight3: UIImage { .load(name: "img_spotlight3") }
    }
    
    enum Home {
        static var imgBearHomeBrown: UIImage { .load(name: "img_bear_home_brown") }
        static var imgBearHomeGray: UIImage { .load(name: "img_bear_home_gray") }
        static var imgBearHomePanda: UIImage { .load(name: "img_bear_home_panda") }
        static var imgBearHomeRed: UIImage { .load(name: "img_bear_home_red") }
        static var icSomColor: UIImage { .load(name: "ic_som_color") }
        static var icSomWhite: UIImage { .load(name: "ic_som_white") }
        static var icLogoHome: UIImage { .load(name: "ic_logo_home") }
        static var icHomeMoney: UIImage { .load(name: "ic_home_money") }
        static var icHomeSettings: UIImage { .load(name: "ic_home_settings") }
        static var pngSpeechHome: UIImage { .load(name: "png_speech_home") }
        static var imgHomebackAllBrown: UIImage { .load(name: "img_homeback_all_brown") }
        static var imgHomebackAllGray: UIImage { .load(name: "img_homeback_all_gray") }
        static var imgHomebackAllPanda: UIImage { .load(name: "img_homeback_all_panda") }
        static var imgHomebackAllRed: UIImage { .load(name: "img_homeback_all_red") }
    }
    
    enum DailyRoutine {
        static var imgDailycard1: UIImage { .load(name: "img_dailycard_1") }
        static var icDaily1Filled: UIImage { .load(name: "ic_daily_1_filled") }
        static var icDaily2Filled: UIImage { .load(name: "ic_daily_2_filled") }
        static var icDaily3Filled: UIImage { .load(name: "ic_daily_3_filled") }
        static var icDaily4Filled: UIImage { .load(name: "ic_daily_4_filled") }
        static var icDaily5Filled: UIImage { .load(name: "ic_daily_5_filled") }
        static var icDaily6Filled: UIImage { .load(name: "ic_daily_6_filled") }
        static var icDaily7Filled: UIImage { .load(name: "ic_daily_7_filled") }
        static var icDaily8Filled: UIImage { .load(name: "ic_daily_8_filled") }
        static var icDaily9Filled: UIImage { .load(name: "ic_daily_9_filled") }
        static var icDaily10Filled: UIImage { .load(name: "ic_daily_10_filled") }
        static var icDaily11Filled: UIImage { .load(name: "ic_daily_11_filled") }
        static var icDaily12Filled: UIImage { .load(name: "ic_daily_12_filled") }
        static var icFlag: UIImage { .load(name: "ic_flag") }
        static var icCheck: UIImage { .load(name: "ic_check") }
        static var btnRadiobtnNone: UIImage { .load(name: "btn_radiobtn_none") }
        static var btnRadiobtnSelected: UIImage { .load(name: "btn_radiobtn_selected") }
    }
    
    enum HappyRoutine {
        static var imgHappycardText: UIImage { .load(name: "img_happycard_text") }
        static var imgHappyAdd: UIImage { .load(name: "img_happy_add") }
        static var icHappyRed: UIImage { .load(name: "ic_happy_red") }
        static var icHappyOrange: UIImage { .load(name: "ic_happy_orange") }
        static var icHappyGreen: UIImage { .load(name: "ic_happy_green") }
        static var icHappyBlue: UIImage { .load(name: "ic_happy_blue") }
        static var icHappyPurple: UIImage { .load(name: "ic_happy_purple") }
        static var icHappyBlingRed: UIImage { .load(name: "ic_happy_bling_red") }
        static var icMagnify: UIImage { .load(name: "ic_magnify") }
        static var icTransfer: UIImage { .load(name: "ic_transfer") }
        static var icTime: UIImage { .load(name: "ic_time") }
        static var icPlace: UIImage { .load(name: "ic_place") }
        static var icNext: UIImage { .load(name: "ic_next") }
        static var imgSpeechHappy: UIImage { .load(name: "img_speech_happy") }
    }
    
    enum Setting {
        static var imgBoxLogout: UIImage { .load(name: "img_box_logout") }
        static var icUserSecurity: UIImage { .load(name: "ic_user_security") }
        static var icDocument: UIImage { .load(name: "ic_document") }
        static var icGuide: UIImage { .load(name: "ic_guide") }
        static var icFeedback: UIImage { .load(name: "ic_feedback") }
        static var icSettingRight: UIImage { .load(name: "ic_setting_right") }
    }
}
