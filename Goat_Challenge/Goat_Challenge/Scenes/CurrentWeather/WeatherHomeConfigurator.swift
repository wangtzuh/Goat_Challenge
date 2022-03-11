//
//  WeatherHomeConfigurator.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

protocol WeatherHomeConfiguratorDelegate {
    func configure(_ viewController: WeatherHomeViewController)
}

class WeatherHomeConfigurator: WeatherHomeConfiguratorDelegate {
    
    func configure(_ viewController: WeatherHomeViewController) {
        let apiGateway = APIOpenWeatherGateway()
        let fetchUsecase = FetchOpenWeatherOneCallUsecase(gateway: apiGateway)
        let locationManager = GCLocationManager()
        let presenter = WeatherHomePresenter(view: viewController,
                                             fetchWeatherUsecase: fetchUsecase,
                                             locationManager: locationManager)
        viewController.presenter = presenter
    }
}
