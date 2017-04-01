//
//  Day.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation

class Day {
    var date: Date
    var events: [Event]
    
    init(date: Date, events: [Event]) {
        self.date = date
        self.events = events
    }
}
