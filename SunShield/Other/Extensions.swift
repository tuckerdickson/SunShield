//
//  Extensions.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import Foundation

extension Date {
    func formatDayAbbreviated() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    func formatTimeAbbreviated() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}
