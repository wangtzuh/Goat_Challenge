//
//  APIWeatherData.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

/// API entity directly decoded from JSON
struct APIWeatherOneCallData: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: APICurrentWeatherData
    let hourly: [APIHourlyForcaseData]
    let daily: [APIDailyForcastData]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}

struct APICurrentWeatherData: Codable {
    let date: Double
    let sunrise: Double
    let sunset: Double
    let temperature: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let visibility: Int
    let windSpeed: Double
    let windDirection: Int
    let windGust: Double
    let description: [APIWeatherData]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise
        case sunset
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi = "uvi"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDirection = "wind_deg"
        case windGust = "wind_gust"
        case description = "weather"
    }
}

struct APIHourlyForcaseData: Codable {
    let date: Double
    let temperature: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDegree: Double
    let windGust: Double
    let description: [APIWeatherData]
    let precipitation: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case windGust = "wind_gust"
        case description = "weather"
        case precipitation = "pop"
    }
}

struct APIDailyForcastData: Codable {
    let date: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Double
    let moonset: Double
    let moonPhase: Double
    let temperature: APIDailyForcaseTemperature
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDegree: Int
    let description: [APIWeatherData]
    let clouds: Int
    let precipitation: Double
    
    struct APIDailyForcaseTemperature: Codable {
        let day: Double
        let min: Double
        let max: Double
        let night: Double
        let eve: Double
        let morn: Double
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temperature = "temp"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case description = "weather"
        case clouds
        case precipitation = "pop"
    }
    
}

struct APIWeatherData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

