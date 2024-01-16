//
//  HomeService.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/16/24.
//

import Foundation

import Alamofire

final class HomeService: BaseService {
    
    static let shared = HomeService()
    
    private override init() {}
}

extension HomeService {
    
    func getHomeAPI(socialAccessToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.homeURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(socialAccessToken)"]
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
                                                     HomeEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
