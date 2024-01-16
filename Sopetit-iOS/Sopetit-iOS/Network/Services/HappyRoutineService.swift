//
//  HappyRoutineService.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/12.
//

import Foundation

import Alamofire

final class HappyRoutineService: BaseService {
    
    static let shared = HappyRoutineService()
    
    private override init() {}
}

extension HappyRoutineService {
    
    func getHappinessThemesAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.happinessThemesURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
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
                                                     HappinessThemesEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getHappinessAPI(themeId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        var url = URLConstant.happinessURL + "?themeId=\(themeId)"
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
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
                                                     HappinessEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getHappinessRoutineAPI(routineId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        var url = URLConstant.happinessRoutineURL + "\(routineId)"
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
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
                                                     HappinessRoutineEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
