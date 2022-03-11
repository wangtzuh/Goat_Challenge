//
//  APIResponse.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation


enum Result<T> {
    case success(T)
    case failure(APIError)
    
    public func dematerialize() throws -> T {
        switch self {
        case .success(let entity):
            return entity
        case .failure(let apiError):
            throw apiError.error
        }
    }
}

struct APIResponse<T: Codable> {
    let entity: T
    let urlResponse: HTTPURLResponse
    
    init(_ entity: T, _ response: HTTPURLResponse) {
        self.entity = entity
        self.urlResponse = response
    }
}

struct APIError: Error {
    let type: APIErrorType
    let error: Error
    var code: Int?
    var message: String?
}

enum APIErrorType {
    case statusCode
    case urlError
    case serialization
    case unknown
}
