//
//  EventsViewController.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 01/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
let eventCellIdentifier = "eventCell"

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EventsDelegate     {
    
    private var events: [EventViewModel] = [EventViewModel]()
    var checkedEvents: [EventViewModel] = [EventViewModel]()
    
    var delegate: CalendarDelegate!
    var dataProvider: DataProvider!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: eventCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider.requestEventsViewModel { events in
            self.events = events
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath) as? EventCell {
            let checked = checkedEvents.contains{ $0 == events[indexPath.row] }
            cell.configure(events[indexPath.row], checked: checked )
            if checked {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EventCell else{
            return
        }
        checkedEvents.append(cell.event)
        delegate.updateCell(checkedEvents)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        if let index = checkedEvents.index(where: { $0 == event }) {
            checkedEvents.remove(at: index)
        }
        
        delegate.updateCell(checkedEvents)
        tableView.reloadData()
    }
    
    func replaceOldEventsWith(_ checkedEvents: [EventViewModel]) {
        self.checkedEvents = checkedEvents
        tableView.reloadData()
    }
}

protocol EventsDelegate {
    func replaceOldEventsWith(_ checkedEvents: [EventViewModel])
}

