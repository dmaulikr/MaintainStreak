//
//  ViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
import Foundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var days: [Day] = [Day]()
    @IBOutlet weak var calendarView: UICollectionView!
    var month: DateComponents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        //get saved month
        month = Date().month
        //get saved days
        generateDaysInCalendar()
        
        //load current days using current month
        loadDaysFromMonth()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            cell.configure(day: days[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func generateEvents() -> [Event] {
        let event1 = Event(id: 0, name: "Paint", description: "Fun way to relax", color:
            UIColor(red: 255/255, green: 212/255, blue: 144/255, alpha: 1))
        let event2 = Event(id: 1, name: "Visit SO", description: "Continuous learning", color:
            UIColor(red: 84/255, green: 106/255, blue: 123/255, alpha: 1))
        let event3 = Event(id: 2, name: "Watch an hour of iOS lesson", description: "Learn", color: UIColor(red: 158/255, green: 163/255, blue: 176/255, alpha: 1))
        let event4 = Event(id: 3, name: "Personal Prj", description: "Work on your personal project", color: UIColor(red: 250/255, green: 225/255, blue: 223/255, alpha: 1))
        return [event1, event2, event3, event4]
    }
    
    func generateDaysInCalendar() {
        
        let events = generateEvents()
        
        let day1 = Day(date: Date(), events: [events[0], events[2]])
        days.append(day1)
        
        let day2 = Day(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, events: [events[0], events[1]])
        days.append(day2)
        
        let day3 = Day(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, events: [events[0], events[3]])
        days.append(day3)
        
        days.sort{
            $0.date < $1.date
        }
    }
    
    func loadDaysFromMonth() {
        let today = month.date
        _ = month.dateRange(startDate: today.firstDayOfMonth, endDate: today.lastDayOfMonth) { day in 
            if days.filter({$0.date == day}).count != 1 {
                days.append( Day(date: Date(), events: []))
            }
        }
        
        days.sort{
            $0.date < $1.date
        }
    }
}

