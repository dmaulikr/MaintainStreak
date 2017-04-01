//
//  EventsViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 01/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var events: [Event] = [Event]()
    var checkedEvents: [Event] = [Event]()
    
    var delegate: CalendarDelegate!
    var dataSource: EventsDataSource!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        events = dataSource.loadEvents()
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell {
            let checked = checkedEvents.contains{ $0.id == events[indexPath.row].id }
            cell.configure(events[indexPath.row], checked: checked )
            if checked {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkedEvents.append(events[indexPath.row])
        delegate.updateDayInCalendar()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        if let index = checkedEvents.index(where: { $0.id == event.id }) {
            checkedEvents.remove(at: index)
        }
        
        delegate.updateDayInCalendar()
        tableView.reloadData()
    }

}

protocol EventsDelegate {
    func refreshEvents(_ events: [Event])
}

protocol EventsDataSource {
    func loadEvents() -> [Event]
}
