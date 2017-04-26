//
//  MonthLoader.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 30/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataProvider {
    
    private var dataStore: DataStore
    var fetchedResultsController: NSFetchedResultsController<Event>!
    
    lazy var monthYear: DateComponents! = {
        return Date().adding(months: 0)?.monthYear
    }()
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataStore.mainContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func requestEventsViewModel(_ completion: (_ data: [EventViewModel]) -> ()) {
        requestEvents { events in
            var eventViewModels: [EventViewModel] = []
            for event in events {
                eventViewModels.append(EventViewModel(event))
            }
            completion(eventViewModels)
        }
        
    }
    
    private func requestEvents(_ completion: (_ data: [Event])->()) {
        completion(fetchEvents())
    }
    
    func requestDays(month: DateComponents, completion: (_ data: [DayViewModel]) -> ()) {
        completion(loadDaysFromMonth(month))
    }
    
    private func loadDaysFromMonth(_ monthYear: DateComponents!) -> [DayViewModel]{
        var daysInThisMonth = [DayViewModel]()
        let today = monthYear.dateFromComponents
        let daysInDB = fetchDays()
        
        _ = monthYear.dateRange(startDate: today.firstDayOfMonth, endDate: today.lastDayOfMonth) { date in
            let savedDay = daysInDB.filter({ $0.date.dayEqualTo(date) })
            if  savedDay.count != 1 {
                daysInThisMonth.append( DayViewModel(saveDay(date: date)))
            } else {
                let dayInDB = savedDay.first!
                daysInThisMonth.append(DayViewModel(dayInDB))
            }
        }
        
        daysInThisMonth.sort{
            $0.date < $1.date
        }
        return daysInThisMonth
    }
    
    private func generateEvents() -> [Event] {
        let event1 = Event(context: dataStore.mainContext)
        event1.name = "Paint"
        event1.summary = "Fun way to relax"
        event1.color = UIColor(red: 255/255, green: 212/255, blue: 144/255, alpha: 1)
        
        let event2 = Event(context: dataStore.mainContext)
        event2.name = "Visit SO"
        event2.summary = "Continuous learning"
        event2.color =  UIColor(red: 84/255, green: 106/255, blue: 123/255, alpha: 1)
        
        let event3 = Event(context: dataStore.mainContext)
        event3.name = "Watch an hour of iOS lesson"
        event3.summary = "Learn"
        event3.color = UIColor(red: 158/255, green: 163/255, blue: 176/255, alpha: 1)
        
        let event4 = Event(context: dataStore.mainContext)
        event4.name = "Personal Prj"
        event4.summary = "Work on your personal project"
        event4.color = UIColor(red: 250/255, green: 225/255, blue: 223/255, alpha: 1)
        
        dataStore.saveContext()
        return [event1, event2, event3, event4]
    }
    
    private func fetchEvents() -> [Event] {
        do {
            let eventFetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            let events = try dataStore.mainContext.fetch(eventFetchRequest)
            return events
        }
        catch {
            print(error)
            return []
        }
    }
    
    private func fetchDays() -> [Day] {
        do {
            let dayFetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
            let days = try dataStore.mainContext.fetch(dayFetchRequest)
            return days
        }
        catch {
            print(error)
            return []
        }
    }
    
    func saveDay(date: Date) -> Day {
        let day = Day(context: dataStore.mainContext)
        day.date = date
        day.events = []
        dataStore.saveContext()
        
        return day
    }
    
    func updateEvents(day: Day, events: NSSet) {
        day.events = events
        dataStore.saveContext()
    }
}
