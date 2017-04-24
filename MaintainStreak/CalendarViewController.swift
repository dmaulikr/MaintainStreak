//
//  CalendarViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 31/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CalendarDelegate {
    
    @IBOutlet weak var calendarView: UICollectionView!
    var days: [DayViewModel]!
    var dataFetcher: DataFetcher!
    var delegate: EventsDelegate!
    
    var selectedDay: DayViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        dataFetcher.requestDays(month: dataFetcher.monthYear) { [unowned self] days in
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
        delegate.replaceOldEventsWith(days[indexPath.row].events)
        selectedDay = days[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            cell.addEvents(dataFetcher: dataFetcher)
            cell.configure(day: days![indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func setTodaySelected() {
        
        let selectedDate = Date()
        
        if let day = days.index(where: { $0.date.dayEqualTo(selectedDate) }) {
            calendarView.selectItem(at: IndexPath(row: day, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
            selectedDay = days[day]
            delegate.replaceOldEventsWith(days[day].events)
        }
    }
    
    func updateCell(_ checkedEvents: [EventViewModel]) {
            selectedDay.events = checkedEvents
            let selectedIndex = calendarView.indexPathsForSelectedItems
            calendarView.reloadData()
            calendarView.selectItem(at: selectedIndex?.first, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
    }
}

protocol CalendarDelegate {
    func updateCell(_ checkedEvents: [EventViewModel])
}
