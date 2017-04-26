//
//  SeetingsVC.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 26/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit
import CoreData

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchResultsController: NSFetchedResultsController<Event>!
    var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchResultsController = dataProvider.fetchedResultsController
        fetchResultsController.delegate = self
        
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: eventCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        try? fetchResultsController.performFetch()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let eventCell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath) as? EventCell {
            configureCell(cell: eventCell, indexPath: indexPath)
            return eventCell
        }
        return UITableViewCell()
    }
    
    func configureCell(cell: EventCell, indexPath: IndexPath) {
        let event = fetchResultsController.object(at: indexPath)
        let eventModel = EventViewModel(event)
        cell.configure(eventModel, checked: false)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! EventCell
                configureCell(cell: cell, indexPath: indexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
}
