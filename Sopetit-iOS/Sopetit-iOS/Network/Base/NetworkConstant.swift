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
         "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MywiaWF0IjoxNzA0OTQ5Mzg5LCJleHAiOjE3MDYxNTkzODl9.OnsKaJ9NagxGQx4i0T6_GFdIIn6ZtAph2XHD1zAsDtUbomVToXE3SSgsKvQi32yP8FaZxiCnKzRPn0I2Tb5bDw"]
        return headers
    }
}
