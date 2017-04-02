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
    var calendarVC: CalendarViewController!
    
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
                calendarVC.delegate = self
                self.calendarVC = calendarVC
            }
        case "eventsVC":
            if let eventsVC = segue.destination as? EventsViewController {
                self.eventsVC = eventsVC
                eventsVC.dateFetcher = dateFetcher
                eventsVC.delegate = self
            }
        default: break
        }
    }
    
    func updateDayInCalendar(_ checkedEvents: [Event]) {
        calendarVC.selectedDay.events = checkedEvents
        calendarVC.reloadData()
    }
    
    func changeEventsDisplayed(_ day: Day) {
        eventsVC?.checkedEvents = day.events
        eventsVC?.reloadData()
    }
}



