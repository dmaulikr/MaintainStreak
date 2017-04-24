//
//  Day+CoreDataClass.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 11/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import CoreData

@objc(Day)
public class Day: NSManagedObject {

    convenience init(date: Date, events: [Event]) {
        self.init()
        self.date = date
        self.events = events
    }

}
