//
//  Day+CoreDataProperties.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 11/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: Date!
    @NSManaged public var events: [Event]!
}

// MARK: Generated accessors for events
extension Day {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
