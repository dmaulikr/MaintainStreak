//
//  Date+Ext.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 25/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
}
