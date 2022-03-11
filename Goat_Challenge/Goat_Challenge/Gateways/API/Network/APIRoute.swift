//
//  APIRoute.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

enum APIRoute {
    
    case onecall
    case exampleWithParameter(param: String)
    
    var path: String {
        switch self {
        case .onecall:
            return "onecall"
        case .exampleWithParameter(let param):
            return "test_route_with_param: \(param)"
        }
    }
    
}
