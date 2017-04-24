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
    
    init(_ event: Event) {
        color = event.color
        name = event.name
        summary = event.summary
    }
}

func ==(lhs: EventViewModel, rhs: EventViewModel) -> Bool {
    return lhs.color == rhs.color && lhs.name == rhs.name && lhs.summary == rhs.summary
}
