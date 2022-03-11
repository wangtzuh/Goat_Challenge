//
//  WeatherHomeView.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

/// ViewController related methods
protocol WeatherHomeView: AnyObject {
    func animateIndicatorView()
    func reloadTableView()
    func routeToDetailPage(with detail: DailyForcastData)
}

/// Passive MVP's V layer methods to update the UI
protocol WeatherTableHeaderViewDelegate {
    func display(city: String, current: Int, description: String, max: Int, min: Int)
}

protocol DailyWeatherForcastCellDelegate {
    func display(date: String, iconUrl: String, minTemp: Int, maxTemp: Int)
}
