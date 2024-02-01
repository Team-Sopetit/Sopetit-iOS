//
//  NetworkResult.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case reissue(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
