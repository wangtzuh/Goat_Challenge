//
//  DailyWeatherCell.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit

class DailyWeatherForcastCell: UITableViewCell {
    
    static let identifier = "DailyWeatherForcastCel"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

