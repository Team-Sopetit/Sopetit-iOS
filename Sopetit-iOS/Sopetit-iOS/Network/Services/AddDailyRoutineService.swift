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
    
    func postAddDailyMember(routineId: [Int], completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.addDailyMemberURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [ "routineIds": routineId ]
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
                                                     EmptyEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func postAddChallenge(challengeId: Int,
                          completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.challengeMemberURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [ "challengeId": challengeId ]
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
                                                     AddChallengeEntity.self)
                print("🥹🥹addchallenge🥹🥹")
                dump(networkResult)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func delChallenge(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.challengeMemberURL
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
                                                     EmptyEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    // AddRoutineService
    
    func getDailyRoutine(id: Int,
                         completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.dailyThemeURL + "\(id)"
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
                                                     DailyThemeEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getChallengeRoutine(id: Int,
                             completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.challengeThemeURL + "\(id)"
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
                                                     RoutineChallengeEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getChallengeMember(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.challengeMemberURL
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
                                                     ChallengeMemberEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func postRoutineCustom(
        content: String,
        themeId: Int,
        alarmTime: String,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        let url = URLConstant.routinesCustomURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [
            "content": content,
            "themeId": themeId,
            "alarmTime": alarmTime
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
                                                     RoutineCustomEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
