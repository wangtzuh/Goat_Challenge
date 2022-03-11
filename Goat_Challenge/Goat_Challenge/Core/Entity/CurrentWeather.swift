//
//  CurrentWeather.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

/// Entity Models
struct WeatherOneCallData {
    let longitude: Double
    let latitude: Double
    let timezone: String
    let timezoneOffset: Int
    
    let currentData: CurrentWeatherData
    let dailyData: [DailyForcastData]
}

struct CurrentWeatherData {
    let time: Date
    let sunrise: Date
    let sunset: Date
    let temperature: Int
    let description: WeatherDescription
}

struct DailyForcastData {
    let weekDate: Date
    let sunrise: Date
    let sunset: Date
    let minTemperature: Int
    let maxTemperature: Int
    let humidity: Int
    let description: WeatherDescription
}

struct WeatherDescription {
    let id: Int
    let mainStatus: String
    let description: String
    let icon: String
}
