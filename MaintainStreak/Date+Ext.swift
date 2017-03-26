//
//  Date+Ext.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 25/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation

let gregCalendar = Calendar(identifier: .gregorian)

extension Date {
    
    var dayOfTheMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var firstDayOfMonth: Date {
        return gregCalendar.date(from: gregCalendar.dateComponents([.year, .month], from: gregCalendar.startOfDay(for: self)))!
    }
    
    var lastDayOfMonth: Date {
        let dayRange = gregCalendar.range(of: .day, in: .month, for: self)
        let dayCount = dayRange?.count
        var comp = gregCalendar.dateComponents([.year, .month, .day], from: self)
        comp.day = dayCount
        
        return gregCalendar.date(from: comp)!
    }
    
    var month: DateComponents {
        return gregCalendar.dateComponents([.month], from: self)
    }
}

extension DateComponents {
    
    var date: Date {
        if let d = gregCalendar.date(from: self) {
            return d
        }
        return Date()
    }
    
    func dateRange(startDate: Date, endDate: Date, completion: (_ day: Date) -> ())  {
        var date = startDate
        while date <= endDate {
            completion(date)
            date = gregCalendar.date(byAdding: .day, value: 1, to: date)!
        }
    }
}
