//
//  CalendarCell.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var day: Day!
    
    @IBOutlet weak var color1: UIView!
    @IBOutlet weak var color2: UIView!
    @IBOutlet weak var color3: UIView!
    @IBOutlet weak var color4: UIView!
    
    var colorfullViews = [UIView]()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewInCell: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(red: 84/255, green: 106/255, blue: 123/255, alpha: 1) : nil 
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorfullViews = [color1, color2, color3, color4]
    }
    
    func configure(day: Day){
        self.day = day
        let eventsCount = day.events.count
        guard eventsCount >= 0 && eventsCount <= 4 else { return }
        
        for view in colorfullViews {
            view.backgroundColor = UIColor.white
        }
        
        for event in day.events {
            colorfullViews[event.id].backgroundColor = event.color
        }
        
        dateLabel.text = day.date.dayOfTheMonth
    }
}
