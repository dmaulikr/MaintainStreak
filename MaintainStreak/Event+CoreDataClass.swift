//
//  Event+CoreDataClass.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 25/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Event)
public class Event: NSManagedObject {
    
    convenience init(name: String, summary: String, color: UIColor) {
        self.init()
        self.color = color
        self.name = name
        self.summary = summary
    }
}
