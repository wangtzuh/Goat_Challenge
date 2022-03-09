//
//  WeatherHomePresenter.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

protocol WeatherHomePresenterDelegate: Any {
    
    func configureWeatherTableHeader()
    func configureHourlyWeatherSection()
    func configureDailyWeatherCell()
    
    func didSelectAllowForLocation()
    func didSelectRowAt(indexPath: IndexPath)
}

