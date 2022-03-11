//
//  DateUtil.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/11/22.
//

import Foundation

class DateUtil {
    
    static let dateFormatter = DateFormatter()
    
    static func convertToWeekDay(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    static func convertToTime(_ date: Date) -> String {
        dateFormatter.dateFormat = "h:mm: a"
        return dateFormatter.string(from: date)
    }
}
