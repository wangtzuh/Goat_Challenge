//
//  APIClient.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/8/22.
//

import Foundation
import Alamofire


class APIClient {
        
    public static let shared = APIClient()
    private static var apiConfigs: APIConfiguration?
    private var session: Session
    
    class func setup(_ configs: APIConfiguration) {
        APIClient.apiConfigs = configs
    }
    
    private init() {
        guard let _ = APIClient.apiConfigs else {
            fatalError("Message: must call setup before accessing APIClient")
        }
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60
        session = Session.init(configuration: sessionConfig, delegate: SessionDelegate.init())
    }
    
    public func getRequest<T: Decodable>(route: APIRoute, param: Parameters?, header: HTTPHeaders?, completion: @escaping (Result<APIResponse<T>>) -> Void) {
        httpRequest(route: route, method: .get, params: param, header: header) { (response: Result<APIResponse<T>>) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func postRequest<T: Decodable>(route:APIRoute, param: Parameters?, header: HTTPHeaders?, completion: @escaping (Result<APIResponse<T>>) -> Void) {
        httpRequest(route: route, method: .post, params: param, header: header) { (response: Result<APIResponse<T>>) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func httpRequest<T: Decodable>(route: APIRoute, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders?, completion: @escaping (Result<APIResponse<T>>) -> Void) {
        guard let domain = APIClient.apiConfigs?.domain else {
            return
        }
        let requestUrl: String = "\(domain)/\(route.path)"
        
        session.request(requestUrl, method: method, parameters: params, encoding: encoding, headers: header)
            .validate(statusCode: 200..<299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let target):
                    completion(.success(APIResponse(target, response.response!)))
                case .failure(let afError):
                    if afError.isResponseValidationError {
                        let statusError = APIError(type: .statusCode, error: afError, code: afError.responseCode, message: afError.errorDescription)
                        completion(.failure(statusError))
                    }
                    if afError.isResponseSerializationError {
                        let error = APIError(type: .serialization, error: afError, code: nil, message: afError.errorDescription)
                        completion(.failure(error))
                    }
                    if afError.isInvalidURLError {
                        let error = APIError(type: .urlError, error: afError, code: nil, message: afError.errorDescription)
                        completion(.failure(error))
                    }
                }
                
            }
  
    }
}
