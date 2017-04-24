//
//  EventViewModel.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation
import UIKit

class EventViewModel: Equatable{
    
    var color: UIColor
    var name: String
    var summary: String
    
    var event: Event
    
    init(_ event: Event) {
        self.event = event
        color = event.color
        name = event.name
        summary = event.summary
    }
}

func ==(lhs: EventViewModel, rhs: EventViewModel) -> Bool {
    return lhs.color == rhs.color && lhs.name == rhs.name && lhs.summary == rhs.summary
}
