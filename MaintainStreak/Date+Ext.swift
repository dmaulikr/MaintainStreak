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
    
    func adding(days: Int) -> Date? {
        
        var components = DateComponents()
        components.calendar = gregCalendar
        components.day = days
        
        return gregCalendar.date(byAdding: components, to: self)
    }
    
    var descriptionWithLongMonthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        
        return formatter.string(from: self)
    }
    
    var descriptionOfDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMMM, yyyy"
        
        return formatter.string(from: self)
    }
    
    var startOfWeek: Date {
        var component = gregCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        component.to12am()
        return gregCalendar.date(from: component)!
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    var howManyDaysFromBeginingOfWeek: Int {
        let beginingOfWeek = startOfWeek
        let diff = self.interval(ofComponent: .day, fromDate: beginingOfWeek)
        return diff
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
        }
    }
    
    mutating func to12am() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}
