//
//  CalendarViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 31/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var calendarView: UICollectionView!
    var days: [Day]!
    var dateFetcher: DateFetcher!
    var delegate: CalendarDelegate!
    
    var selectedDay: Day!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        dateFetcher.requestDays(month: dateFetcher.monthYear) { days in
            self.days = days
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTodaySelected()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.changeEventsDisplayed(days[indexPath.row])
        selectedDay = days[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            cell.configure(day: days[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func setTodaySelected() {
        
        let selectedDate = Date()
        
        if let day = days.index(where: { $0.date.dayEqualTo(selectedDate) }) {
            calendarView.selectItem(at: IndexPath(row: day, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
            selectedDay = days[day]
            delegate.changeEventsDisplayed(days[day])
        }
    }
    
    func reloadData() {
        calendarView.reloadData()
    }
}

protocol CalendarDelegate {
    
    func changeEventsDisplayed(_ day: Day)
    
}
