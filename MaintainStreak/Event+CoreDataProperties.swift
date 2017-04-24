//
//  Event+CoreDataProperties.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 11/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var color: UIColor
    @NSManaged public var name: String
    @NSManaged public var summary: String
}
