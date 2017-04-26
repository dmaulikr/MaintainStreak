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
    
    var eventsVC: EventsVC!
    var calendarVC: CalendarVC!
    
    var monthYear: DateComponents! {
        didSet {
            navigatorTitle.text = monthYear.dateFromComponents.descriptionWithLongMonthAndYear
        }
    }
    
    var dataProvider: DataProvider!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventsVC.delegate = calendarVC
        calendarVC.delegate = eventsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthYear = dataProvider.monthYear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "calendarVC":
            if let calendarVC = segue.destination as? CalendarVC {
                calendarVC.dataProvider = dataProvider
                self.calendarVC = calendarVC
            }
        case "eventsVC":
            if let eventsVC = segue.destination as? EventsVC {
                self.eventsVC = eventsVC
                eventsVC.dataProvider = dataProvider
            }
            
        case "settingsVC":
            if let settingsVC = segue.destination as? SettingsVC {
                settingsVC.dataProvider = dataProvider
            }
        default: break
        }
    }
}



