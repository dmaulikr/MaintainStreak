//
//  MonthLoader.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 30/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import UIKit

class DateFetcher: EventsDataSource {
    
    lazy var monthYear: DateComponents! = {
        return Date().adding(months: 0)?.monthYear
    }()
    
    func requestEvents(completion: (_ data: [Event])->()) {
        completion(loadEvents())
    }
    
    func requestDays(month: DateComponents, completion: (_ data: [Day]) -> ()) {
        completion(loadDaysFromMonth(month))
    }
    
    private func loadDaysFromMonth(_ monthYear: DateComponents!) -> [Day]{
        var daysInThisMonth = [Day]()
        let today = monthYear.dateFromComponents
        let days = generateDaysInCalendar()
        
        _ = monthYear.dateRange(startDate: today.firstDayOfMonth, endDate: today.lastDayOfMonth) { day in
            let savedDay = days.filter({ $0.date.dayEqualTo(day) })
            if  savedDay.count != 1 {
                daysInThisMonth.append( Day(date: day, events: []))
            } else {
                daysInThisMonth.append(savedDay.first!)
            }
        }
        
        daysInThisMonth.sort{
            $0.date < $1.date
        }
        return daysInThisMonth
    }
    
    private func insertDaysBeforeMonday(daysInThisMonth: inout [Day]) {
        let firstDayOfMonth = daysInThisMonth.first
        let numberOfDaysFromMonday: Int = (firstDayOfMonth?.date.howManyDaysFromBeginingOfWeek)!
        
        for i in 1...numberOfDaysFromMonday - 1 {
            let date = firstDayOfMonth?.date.adding(days: -i)
            daysInThisMonth.append(Day(date: date!, events: []))
        }
    }
    
    internal func loadEvents() -> [Event] {
        let event1 = Event(id: 0, name: "Paint", description: "Fun way to relax", color:
            UIColor(red: 255/255, green: 212/255, blue: 144/255, alpha: 1))
        let event2 = Event(id: 1, name: "Visit SO", description: "Continuous learning", color:
            UIColor(red: 84/255, green: 106/255, blue: 123/255, alpha: 1))
        let event3 = Event(id: 2, name: "Watch an hour of iOS lesson", description: "Learn", color: UIColor(red: 158/255, green: 163/255, blue: 176/255, alpha: 1))
        let event4 = Event(id: 3, name: "Personal Prj", description: "Work on your personal project", color: UIColor(red: 250/255, green: 225/255, blue: 223/255, alpha: 1))
        return [event1, event2, event3, event4]
    }
    
    internal func generateDaysInCalendar() -> [Day]{
        var days = [Day]()
        let events = loadEvents()
        
        let day1 = Day(date: Date(), events: [events[0], events[2]])
        days.append(day1)
        
        let day2 = Day(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, events: [events[0], events[1]])
        days.append(day2)
        
        let day3 = Day(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, events: [events[0], events[3]])
        days.append(day3)
        
        days.sort{
            $0.date < $1.date
        }
        
        return days
    }
}
