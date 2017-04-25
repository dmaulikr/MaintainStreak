//
//  Event+CoreDataProperties.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 25/04/2017.
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
    @NSManaged public var day: NSSet

}

// MARK: Generated accessors for day
extension Event {

    @objc(addDayObject:)
    @NSManaged public func addToDay(_ value: Day)

    @objc(removeDayObject:)
    @NSManaged public func removeFromDay(_ value: Day)

    @objc(addDay:)
    @NSManaged public func addToDay(_ values: NSSet)

    @objc(removeDay:)
    @NSManaged public func removeFromDay(_ values: NSSet)

}
