//
//  WeatherHomePresenter.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import Foundation

protocol WeatherHomePresenterDelegate: Any {
    
    var numberOfSection: Int {get}
    
    func viewDidLoad()
    
    func numberOfRows(in section: Int) -> Int
    func heightForHeader(in section: Int) -> Double
    func configureWeatherTableHeader(header: WeatherTableHeaderViewDelegate)
    func configureSectionTitleFor(section: Int) -> String?
    func configureDailyWeatherCell(cell: DailyWeatherForcastCellDelegate, for row: Int)
    
    func didSelectAllowForLocation()
    func didSelectRowAt(indexPath: IndexPath)
}

class WeatherHomePresenter: WeatherHomePresenterDelegate {

    fileprivate weak var view: WeatherHomeView?
    fileprivate let fetchWeatherUsecase: FetchOpenWeatherOneCallUsecaseDelegate
    fileprivate let locationManager: GCLocationManagerProtocol
    var numberOfSection: Int {
        return 2
    }
    
    private var weatherData: WeatherOneCallData?
    
    init(view: WeatherHomeView,
         fetchWeatherUsecase: FetchOpenWeatherOneCallUsecaseDelegate,
         locationManager: GCLocationManagerProtocol) {
        self.view = view
        self.fetchWeatherUsecase = fetchWeatherUsecase
        self.locationManager = locationManager
    }
    
    // MARK: - WeatherHomePresenterDelegate methods
    func viewDidLoad() {
        locationManager.registerObserver(self)
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 1:
            // provide a default value
            return weatherData?.dailyData.count ?? 7
        default:
            return 0
        }
    }
    
    func heightForHeader(in section: Int) -> Double {
        if section == 0 {
            return 200.0
        }
        return 30.0
    }
    
    func configureWeatherTableHeader(header: WeatherTableHeaderViewDelegate) {
        guard let weatherData = weatherData else {
            return
        }

        header.display(city: weatherData.timezone,
                       current: weatherData.currentData.temperature,
                       description: weatherData.currentData.description.description,
                       max: weatherData.dailyData[0].maxTemperature,
                       min: weatherData.dailyData[0].minTemperature)
    }
    
    func configureSectionTitleFor(section: Int) -> String? {
        switch section {
        case 1:
            return "Daily Forcast"
        default:
            return nil
        }
    }
    
    func configureDailyWeatherCell(cell: DailyWeatherForcastCellDelegate, for row: Int) {
        guard let dailyData = weatherData?.dailyData[row] else {
            return
        }
        cell.display(date: DateUtil.convertToWeekDay(dailyData.weekDate),
                     iconUrl: dailyData.description.icon,
                     minTemp: dailyData.minTemperature,
                     maxTemp: dailyData.maxTemperature)
    }
    
    func didSelectAllowForLocation() {
        locationManager.requestLocation()
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let dailyData = weatherData?.dailyData[indexPath.row] else {
            return
        }
        view?.routeToDetailPage(with: dailyData)
    }
}

// MARK: - Request WeatherDataUsecase callbacks
private extension WeatherHomePresenter {
    func requestWeatherData(_ locationData: LocationData) {
        view?.animateIndicatorView()
        let param = FetchOpenWeatherOnceCellParam(locationData.longitude, locationData.latitude)
        fetchWeatherUsecase.fetchOpenWeather(param: param) { result in
            switch result {
            case .success(let data):
                self.handleFetchSuccessResult(data)
            case .failure(let error):
                self.handleFetchFailure(error)
            }
        }
    }
    
    func handleFetchSuccessResult(_ data: WeatherOneCallData) {
        weatherData = data
        view?.reloadTableView()
    }
    
    func handleFetchFailure(_ error: Error) {
        print(error)
    }
}

// MARK: - GCLocationManagerDelegate
extension WeatherHomePresenter: GCLocationManagerDelegate {
    func gclocationManager(_ manager: GCLocationManagerProtocol, isPermissionGranted: Bool) {
        
    }
    
    func gclocationManager(_ manager: GCLocationManagerProtocol, didReceiveLocationData data: LocationData) {
        manager.stopRequestingLocation()
        requestWeatherData(data)
    }
}
