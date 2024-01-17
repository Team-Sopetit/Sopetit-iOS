//
//  RoutinesDailyService.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/17/24.
//

import Foundation

import Alamofire

final class AddDailyRoutineService: BaseService {
    
    static let shared = AddDailyRoutineService()
    
    private override init() {}
}

extension AddDailyRoutineService {
    
    func getDailyThemesAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.dailyThemesURL
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
                                                     DailyThemesEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getDailyRoutinesAPI(themes: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.routinesDailyURL + "?themes=\(themes)"
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
                                                     DailyRoutinesEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func postDailyMember(routineId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.routinesDailyMemberURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [ "routineId": routineId ]
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
                                                     DailyRoutineIdEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
