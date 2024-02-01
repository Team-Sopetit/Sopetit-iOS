//
//  ReissueService.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 2/1/24.
//

import Foundation

import Alamofire

final class ReissueService: ReissueBaseService {
    
    static let shared = ReissueService()
    
    private override init() {}
}

extension ReissueService {
    
    func postReissueAPI(
        refreshToken: String,
        completion: @escaping (Bool) -> Void) {
            let url = URLConstant.reissueURL
            let header: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(refreshToken)"]
            let dataRequest = AF.request(url,
                                         method: .post,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         ReissueEntity.self)
                    switch networkResult {
                    case .success(let data):
                        if let data = data as? GenericResponse<ReissueEntity> {
                            if let accessToken = data.data?.accessToken {
                                UserManager.shared.reissueToken(accessToken)
                                completion(true)
                            }
                        }
                    case .requestErr:
                        completion(false)
                    case .serverErr:
                        break
                    default:
                        break
                    }
                case .failure:
                    break
                }
            }
        }
}
