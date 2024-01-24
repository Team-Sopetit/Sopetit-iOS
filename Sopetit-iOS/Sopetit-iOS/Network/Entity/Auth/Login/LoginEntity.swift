//
//  LoginEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

struct LoginEntity: Codable {
    let accessToken, refreshToken: String
    let isMemberDollExist: Bool
}

struct LogoutEntity: Codable {}

struct ResignEntity: Codable {}

struct ReisuueEntity: Codable {
    let accessToken: String
}
