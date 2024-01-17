//
//  UserManager.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") private(set) var refreshToken
    @UserDefaultWrapper<String>(key: "userIdentifier") private(set) var appleUserIdentifier
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    
    var getAccessToken: String { return self.accessToken ?? "" }
    
    private init() {}
}

extension UserManager {
    
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
    }
}
