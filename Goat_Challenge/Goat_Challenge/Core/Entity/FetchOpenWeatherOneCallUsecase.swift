//
//  FetchOpenWeatherOneCallUsecase.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation
import UIKit

typealias FetchOpenWeatherOnceCallUsecaseCompletion = (_ weatherData: Result<WeatherOneCallData>) -> Void

struct FetchOpenWeatherOnceCellParam: OpenWeatherGatewayParamDelegate {
    
    private let apiKey: String
    var longitude: Double
    var langtitude: Double
    
    init(_ longtitue: Double, _ langtitude: Double, apiKey: String) {
        self.longitude = longtitue
        self.langtitude = langtitude
        self.apiKey = apiKey
    }
    
    func toJSON() -> [String : String] {
        var dict = [String:String]()
        dict["lat"] = "\(langtitude)"
        dict["lon"] = "\(longitude)"
        dict["appid"] = apiKey
        
        dict["exlude"] = "minutely"                 //exclude minutely data
        dict["units"] = "metric"                    // temperature unit as Celsius
        return dict
    }
}

protocol FetchOpenWeatherOneCallUsecaseDelegate {
    func fetchOpenWeather(param: OpenWeatherGatewayParamDelegate, completion: @escaping FetchOpenWeatherOnceCallUsecaseCompletion)
}

class FetchOpenWeatherOneCallUsecase: FetchOpenWeatherOneCallUsecaseDelegate {
    
    private let openWeatherGateway: OpenWeatherGateway
    
    init(gateway: OpenWeatherGateway) {
        self.openWeatherGateway = gateway
    }
    
    func fetchOpenWeather(param: OpenWeatherGatewayParamDelegate, completion: @escaping FetchOpenWeatherOnceCallUsecaseCompletion) {
        openWeatherGateway.fetchOpenWeatherOneCall(param: param) { result in
            completion(result)
        }
    }
}
