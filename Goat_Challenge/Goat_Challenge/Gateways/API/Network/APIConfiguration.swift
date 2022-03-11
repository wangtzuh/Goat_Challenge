//
//  APIConfiguration.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

enum APIConfiguration {
    case development
    case test
    case production
    
    var domain: String {
        switch self {
        case .development:
             return "https://example-development.com"
        case .test:
            return "https://example-test.com"
        case .production:
            return "https://api.openweathermap.org/data/2.5"
        }
    }
    
}
