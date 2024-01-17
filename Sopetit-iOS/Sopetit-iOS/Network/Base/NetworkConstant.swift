//
//  NetworkConstant.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

import Alamofire

enum NetworkConstant {
    static var noTokenHeader: HTTPHeaders = ["Content-Type": "application/json"]
    static var hasTokenHeader: HTTPHeaders {
        var headers: HTTPHeaders =
        ["Content-Type": "application/json",
         "Authorization": "Bearer \(UserManager.shared.getAccessToken)"]
        return headers
    }
}
