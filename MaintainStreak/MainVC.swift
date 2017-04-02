//
//  ViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
import Foundation

class MainVC: UIViewController, CalendarTriggerDelegate, EventsTriggerDelegate {
    
    @IBOutlet weak var navigatorTitle: UILabel!
    
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var eventsContainer: UIView!
    
    var eventsVC: EventsViewController!
    var calendarVC: CalendarViewController!
    
    var eventsDelegate: EventsDelegate!
    var calendarDelegate: CalendarDelegate!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarDelegate = calendarVC
        eventsDelegate = eventsVC
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
    
    func triggerModifyEvents(_ checkedEvents: [Event]) {
       calendarDelegate.changeEventsDisplayed(checkedEvents)
    }
    
    func triggerSelectedDayChanged(_ day: Day) {
        eventsDelegate.eventsChanged(day.events)
    }
}



