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
    
    var monthYear: DateComponents {
        return gregCalendar.dateComponents([.month, .year], from: self)
    }
    
    func dayEqualTo(_ day: Date) -> Bool {
        return gregCalendar.isDate(self, inSameDayAs: day)
    }
    
    func adding(months: Int) -> Date? {
        
        var components = DateComponents()
        components.calendar = gregCalendar
        components.month = months
        
        return gregCalendar.date(byAdding: components, to: self)
    }
    
    var descriptionWithLongMonthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        
        return formatter.string(from: self)
    }
}

extension DateComponents {
    
    var dateFromComponents: Date {
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
            print(date)
        }
    }
}
