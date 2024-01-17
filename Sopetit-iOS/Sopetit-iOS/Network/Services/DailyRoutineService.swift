//
//  DailyRoutineService.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/12.
//

import Foundation

import Alamofire

final class DailyRoutineService: BaseService {
    
    static let shared = DailyRoutineService()
    
    private override init() {}
}

// MARK: - Extension

extension DailyRoutineService {
    func getRoutineListAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.dailyURL
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
                                                     DailyRoutineEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func patchRoutineAPI(
        routineId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.patchRoutineURL + "\(routineId)"
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let dataRequest = AF.request(url,
                                         method: .patch,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         DailyPatchEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func deleteRoutineListAPI(routineId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.deleteURL + "\(routineId)"
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .delete,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     DailyRoutineEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
