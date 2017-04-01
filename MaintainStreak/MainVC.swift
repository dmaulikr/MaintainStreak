//
//  ViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
import Foundation

class MainVC: UIViewController, CalendarDelegate, EventsDelegate {
    
    @IBOutlet weak var navigatorTitle: UILabel!
    
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var eventsContainer: UIView!
    
    var eventsVC: EventsViewController!
    
    var monthYear: DateComponents! {
        didSet {
            navigatorTitle.text = monthYear.dateFromComponents.descriptionWithLongMonthAndYear
        }
    }
    
    var dateFetcher = DateFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthYear = dateFetcher.monthYear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "calendarVC":
            if let calendarVC = segue.destination as? CalendarViewController {
                calendarVC.dateFetcher = dateFetcher
            }
        case "eventsVC":
            if let eventsVC = segue.destination as? EventsViewController {
                self.eventsVC = eventsVC
                eventsVC.dataSource = dateFetcher
                eventsVC.delegate = self
            }
        default: break
        }
    }
    
    func updateDayInCalendar() {
        //        daysInThisMonth[daysInThisMonth.index(where: {$0.date.dayEqualTo(selectedDay.date)})!] = selectedDay
        //        selectedDay.events = eventsForToday
        
    }
    
    func refreshEvents(_ events: [Event]) {
        eventsVC?.events = events
        eventsVC?.tableView.reloadData()
    }
}



