//
//  ViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
import Foundation

class MainVC: UIViewController {
    
    var days: [Day] = [Day]()
    var daysInThisMonth: [Day] = [Day]()
    var events: [Event] = [Event]()
    var eventsForToday: [Event] = [Event]()
    
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigatorTitle: UILabel!
    
    var monthYear: DateComponents! {
        didSet {
            navigatorTitle.text = monthYear.dateFromComponents.descriptionWithLongMonthAndYear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        monthYear = Date().adding(months: 2)?.monthYear
        events = generateEvents()
        generateDaysInCalendar()
        loadDaysFromMonth()
        setTodaySelected()
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
        let today = monthYear.dateFromComponents
        
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
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInThisMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventsForToday = daysInThisMonth[indexPath.row].events
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        eventsForToday = [Event]()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            cell.configure(day: daysInThisMonth[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func setTodaySelected() {
        if let day = daysInThisMonth.index(where: { $0.date.dayEqualTo(Date()) }) {
        calendarView.selectItem(at: IndexPath(row: day, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell {
            cell.configure(events[indexPath.row], checked: eventsForToday.contains{ $0.id == events[indexPath.row].id } )
            return cell
        }
        
        return UITableViewCell()
    }
}

