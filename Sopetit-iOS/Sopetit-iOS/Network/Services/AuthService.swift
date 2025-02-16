//
//  AuthService.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

import Alamofire

final class AuthService: BaseService {
    
    static let shared = AuthService()
    
    private override init() {}
}

extension AuthService {
    func postLoginAPI(
        socialAccessToken: String,
        socialType: String,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.loginURL
            let header: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(socialAccessToken)"]
            let body: Parameters = [
                "socialType": socialType
            ]
            let dataRequest = AF.request(url,
                                         method: .post,
                                         parameters: body,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         LoginEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func postLogoutAPI(
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.logoutURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let dataRequest = AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         LogoutEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func deleteResignAPI(
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.resignURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let dataRequest = AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: header)
            
            dataRequest.responseData { response
                in
                switch response.result {
                case.success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         ResignEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    func getVersionAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.versionURL
        let header: HTTPHeaders = NetworkConstant.noTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     VersionEntity.self)
                completion(networkResult)
            case .failure(let error):
                if let urlError = error.asAFError?.underlyingError as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        print("⏳ 요청이 타임아웃되었습니다.")
                        completion(.networkTimeOut)
                    case .cannotFindHost, .cannotConnectToHost:
                        print("🌍 서버에 연결할 수 없습니다. URL이 변경되었을 가능성이 있습니다.")
                        completion(.networkNoHost)
                    default:
                        print("❌ 기타 네트워크 오류: \(urlError.localizedDescription)")
                        completion(.networkFail)
                    }
                } else {
                    completion(.networkFail)
                }
            }
        }
    }
}
