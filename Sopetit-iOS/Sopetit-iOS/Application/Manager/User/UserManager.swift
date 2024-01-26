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
    @UserDefaultWrapper<String>(key: "userIdentifier") private(set) var appleUserIdentifier
    @UserDefaultWrapper<Bool>(key: "postMember") private(set) var postMember
    @UserDefaultWrapper<String>(key: "dollType") private(set) var dollType
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getRefreshToken: String { return self.refreshToken ?? "" }
    var getSocialType: String { return self.socialType ?? "" }
    var isPostMemeber: Bool { return self.postMember ?? false }
    var getDollType: String { return self.dollType ?? "BROWN" }
    
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
    
    func updateToken(_ accessToken: String, _ refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
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
    }
}
