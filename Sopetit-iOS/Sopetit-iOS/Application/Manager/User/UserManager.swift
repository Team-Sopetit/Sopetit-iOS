//
//  UserManager.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "socialType") private(set) var socialType
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") private(set) var refreshToken
    @UserDefaultWrapper<String>(key: "fcmToken") private(set) var fcmToken
    @UserDefaultWrapper<String>(key: "userIdentifier") private(set) var appleUserIdentifier
    @UserDefaultWrapper<Bool>(key: "postMember") private(set) var postMember
    @UserDefaultWrapper<String>(key: "dollType") private(set) var dollType
    @UserDefaultWrapper<Bool>(key: "showTutorial") private(set) var showTutorial
    @UserDefaultWrapper<Bool>(key: "allowAlarm") private(set) var allowAlarm
    @UserDefaultWrapper<String>(key: "dollName") private(set) var dollName
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getRefreshToken: String { return self.refreshToken ?? "" }
    var getFcmToken: String { return self.fcmToken ?? "" }
    var getSocialType: String { return self.socialType ?? "" }
    var isPostMemeber: Bool { return self.postMember ?? false }
    var getDollType: String { return self.dollType ?? "BROWN" }
    var isShowTutorial: Bool { return self.showTutorial ?? false }
    var hasAllowAlarm: Bool { return self.allowAlarm ?? false }
    var getDollName: String { return self.dollName ?? "" }
    
    private init() {}
}

extension UserManager {
    
    func hasPostMember() {
        self.postMember = true
    }
    
    func updateSocialType(_ socialType: String) {
        self.socialType = socialType
    }
    
    func updateDoll(_ dollType: String) {
        self.dollType = dollType
    }
    
    func updateDollName(_ dollNamee: String) {
        self.dollName = dollNamee
    }
    
    func updateToken(_ accessToken: String, _ refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func updateFcmToken(_ fcmToken: String) {
        self.fcmToken = fcmToken
    }
    
    func setAllowAlarm(_ hasAllow: Bool) {
        self.allowAlarm = hasAllow
    }
    
    func reissueToken(_ accessToken: String) {
        self.accessToken = accessToken
    }
    
    func setUserIdForApple(userId: String) {
        self.appleUserIdentifier = userId
    }
    
    func logout() {
        self.accessToken = nil
        self.refreshToken = nil
    }
    
    func clearAll() {
        self.accessToken = nil
        self.refreshToken = nil
        self.appleUserIdentifier = nil
        self.postMember = false
        self.showTutorial = false
    }
    
    func setShowTutorial() {
        self.showTutorial = true
    }
}
