//
//  OpenWeatherGateway.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation

typealias OpenWeatherOneCallResult = (_ weather: Result<WeatherOneCallData>) -> Void

/// Protocol to define the basic needs as the parameter to fetch the data. The exact implementation would be varied based on the exact usecase. 
protocol OpenWeatherGatewayParamDelegate {
    var longitude: Double {get set}
    var langtitude: Double {get set}
    
    func toJSON() -> [String:String]
}

/// Abstract protocol to define the method to fetch the OpenWeatherOneCall data
protocol OpenWeatherGateway: Any {
    
    /// Abstract method to determine what we need to fetch OpenWeatherOnceCall data and the completion handler
    func fetchOpenWeatherOneCall(param: OpenWeatherGatewayParamDelegate, completion: @escaping OpenWeatherOneCallResult)
}

