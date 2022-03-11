//
//  DetailWeatherView.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import Foundation

protocol DetailWeatherView: AnyObject {
    func reloadTableView()
}

protocol DetailInfoCellDelegate {
    func display(title: String, description: String)
}
