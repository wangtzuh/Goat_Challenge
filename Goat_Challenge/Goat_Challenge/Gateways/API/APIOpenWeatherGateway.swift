//
//  APIOpenWeatherGateway.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation

class APIOpenWeatherGateway: OpenWeatherGateway {
    
    func fetchOpenWeatherOneCall(param: OpenWeatherGatewayParamDelegate, completion: @escaping OpenWeatherOneCallResult) {
        
        
        
        APIClient.shared.getRequest(route: .onecall, param: param.toJSON()) { [self] (result: Result<APIResponse<APIWeatherOneCallData>>) in
            switch result {
            case .success(let apiResponse):
                // Can do futhure caching for something like HttpHeader....
                let entity = convertToEntity(with: apiResponse.entity)
                completion(.success(entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Convert APIEntity to EntityModel that matched the exact busniess logic we want.
    /// - Parameter apiEntity: APIWeahterOneCallData decoded from API request' result
    /// - Returns: OpenWeatherOneCallData
    private func convertToEntity(with apiEntity: APIWeatherOneCallData) -> WeatherOneCallData {
        let current = CurrentWeatherData(time: Date(timeIntervalSince1970: apiEntity.current.date),
                                         sunrise: Date(timeIntervalSince1970: apiEntity.current.sunrise),
                                         sunset: Date(timeIntervalSince1970: apiEntity.current.sunset),
                                         temperature: Int(apiEntity.current.temperature),
                                         description: WeatherDescription(id: apiEntity.current.description[0].id,
                                                                         mainStatus: apiEntity.current.description[0].main,
                                                                         description: apiEntity.current.description[0].description,
                                                                         icon: concatenateIconUrl(apiEntity.current.description[0].icon)))

        let daily: [DailyForcastData] = apiEntity.daily.map{ DailyForcastData(weekDate: Date(timeIntervalSince1970: $0.date),
                                                                              sunrise: Date(timeIntervalSince1970: $0.sunrise),
                                                                              sunset: Date(timeIntervalSince1970: $0.sunset),
                                                                              minTemperature: Int($0.temperature.min),
                                                                              maxTemperature: Int($0.temperature.max),
                                                                              humidity: $0.humidity,
                                                                              description: WeatherDescription(id: $0.description[0].id,
                                                                                                              mainStatus: $0.description[0].main,
                                                                                                              description: $0.description[0].description,
                                                                                                              icon: concatenateIconUrl($0.description[0].icon)))}

        return WeatherOneCallData(longitude: apiEntity.lon,
                                  latitude: apiEntity.lat,
                                  timezone: apiEntity.timezone,
                                  timezoneOffset: apiEntity.timezoneOffset,
                                  currentData: current,
                                  dailyData: daily)
    }
    
    
    /// Hardcoded convertion to concatenate icon name to icon url in OpenWeatherApi
    /// https://openweathermap.org/weather-conditions
    /// - Parameter iconName:
    /// - Returns:
    private func concatenateIconUrl(_ iconName: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconName)@2x.png"
    }
}
