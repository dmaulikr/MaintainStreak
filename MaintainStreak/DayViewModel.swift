//
//  DayViewModel.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation

class DayViewModel {
    
    var date: Date
    var events: [EventViewModel] = []
    
    init(_ day: Day) {
        date = day.date
        for event in day.events {
            events.append(EventViewModel(event))
        }
    }
    
    init(_ dateAsADate: Date) {
        date = dateAsADate
        events = []
    }
}
