//
//  CalendarCell.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var day: DayViewModel!
    
    var colorfullViews = [LittleView]()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewInCell: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor(red: 84/255, green: 106/255, blue: 123/255, alpha: isSelected ? 1 : 0).cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addEvents(dataFetcher: DataFetcher) {
        var dx = 0
        var counter = 0
        let space = 3
        let littleViewWidth = 3
        
        dataFetcher.requestEventsViewModel{ events in
            for event in events {
                counter += 1
                dx = littleViewWidth * (counter - 1) + space * (counter - 1)
                let littleView = LittleView(frame: CGRect(x: space + dx, y: 5, width: littleViewWidth, height: 3))
                littleView.event = event
                self.viewInCell.addSubview(littleView)
                self.colorfullViews.append(littleView)
            }
        }
    }
    
    func configure(day: DayViewModel){
        self.day = day
        let eventsCount = day.events.count
        guard eventsCount >= 0 && eventsCount <= 4 else { return }
        
        for view in colorfullViews {
            view.backgroundColor = UIColor.white
        }
        
        for event in day.events {
            colorfullViews.filter{ $0.event! == event }.first?.backgroundColor = event.color
        }
        
        dateLabel.text = day.date.dayOfTheMonth
    }
}
