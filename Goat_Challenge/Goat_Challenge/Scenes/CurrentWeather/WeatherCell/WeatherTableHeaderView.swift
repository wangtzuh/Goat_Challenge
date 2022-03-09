//
//  WeatherTableHeaderView.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit

class WeatherTableHeaderView: UITableViewHeaderFooterView {

    static let identifier = "WeatherTableHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

