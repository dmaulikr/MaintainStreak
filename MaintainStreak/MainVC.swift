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
    
    var dataStore: DataStore!
    var dataFetcher: DataFetcher!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventsVC.delegate = calendarVC
        calendarVC.delegate = eventsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthYear = dataFetcher.monthYear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "calendarVC":
            if let calendarVC = segue.destination as? CalendarViewController {
                calendarVC.dataFetcher = dataFetcher
                self.calendarVC = calendarVC
            }
        case "eventsVC":
            if let eventsVC = segue.destination as? EventsViewController {
                self.eventsVC = eventsVC
                eventsVC.dataFetcher = dataFetcher
            }
        default: break
        }
    }
}



