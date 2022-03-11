//
//  DetailWeatherPresenter.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation

protocol DetailWeatherPresenterDelegate {
    var dailyWeather: DailyForcastData { get }
    var numberOfItems: Int {get}
    
    func viewDidLoad()
    func configureDetailWeatherCell(cell: DetailInfoCellDelegate, for row: Int)
    
}

class DetailWeatherPresenter: DetailWeatherPresenterDelegate {
    
    fileprivate weak var view: DetailWeatherView?
    internal let dailyWeather: DailyForcastData
    internal let numberOfItems: Int = 7
    
    init(_ data: DailyForcastData, view: DetailWeatherView) {
        self.dailyWeather = data
        self.view = view
    }
    
    func viewDidLoad() {}
    
    func configureDetailWeatherCell(cell: DetailInfoCellDelegate, for row: Int) {
        switch row {
        case 0:
            cell.display(title: "Date: ", description: DateUtil.convertToWeekDay(dailyWeather.weekDate))
        case 1:
            cell.display(title: "Sunrise: ", description: DateUtil.convertToTime(dailyWeather.weekDate))
        case 2:
            cell.display(title: "Sunset: ", description: DateUtil.convertToTime(dailyWeather.weekDate))
        case 3:
            cell.display(title: "Lowest Temp: ", description: "\(dailyWeather.minTemperature)\u{00B0}")
        case 4:
            cell.display(title: "Highest Temp: ", description: "\(dailyWeather.maxTemperature)\u{00B0}")
        case 5:
            cell.display(title: "Humidity", description: "\(dailyWeather.humidity)%")
        case 6:
            cell.display(title: "Status", description: dailyWeather.description.mainStatus)
        default:
            break
        }
    }
}
