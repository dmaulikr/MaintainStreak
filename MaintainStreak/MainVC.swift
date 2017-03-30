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
    
    var daysInThisMonth: [Day] = [Day]()
    var eventsForToday: [Event] = [Event]()
    var events: [Event] = [Event]()
    
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigatorTitle: UILabel!
    
    var monthYear: DateComponents! {
        didSet {
            navigatorTitle.text = monthYear.dateFromComponents.descriptionWithLongMonthAndYear
        }
    }
    
    var monthLoader = MonthLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    
        monthYear = monthLoader.monthYear
        daysInThisMonth = monthLoader.daysInThisMonth
        events = monthLoader.events
        
        setTodaySelected()
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

