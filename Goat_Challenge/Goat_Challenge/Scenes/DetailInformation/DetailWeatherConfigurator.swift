//
//  DetailWeatherConfigurator.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation

protocol DetailWeatherConfiguratorDelegate {
    func configure(_ viewController: DetailWeatherViewController)
}

/// Simple dependency injection for DetailWeatherConfigurator
class DetailWeatherConfigurator: DetailWeatherConfiguratorDelegate {
    
    private let forcastData: DailyForcastData
    
    init(_ forcastData: DailyForcastData) {
        self.forcastData = forcastData
    }
    
    func configure(_ viewController: DetailWeatherViewController) {
        let presenter = DetailWeatherPresenter(forcastData, view: viewController)
        viewController.presenter = presenter
    }
}

