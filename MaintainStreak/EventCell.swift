//
//  EventCell.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 26/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

   
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var event: EventViewModel!
    
    func configure(_ event: EventViewModel, checked: Bool) {
        self.event = event
        colorLabel.backgroundColor = event.color
        titleLabel.text = event.name
        self.accessoryType = checked ? .checkmark: .none
        self.selectionStyle = .none
    }
}
