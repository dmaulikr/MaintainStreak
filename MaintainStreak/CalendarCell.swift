//
//  CalendarCell.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 24/03/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    private var day: DayViewModel!
    
    private var colorfullViews = [LittleView]()
    var defaultEvents: [EventViewModel]!
    
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
    
    func addEvents() {
        guard colorfullViews.count == 0 else { return }
        guard defaultEvents.count != 0 else { return }
      
        let width = Double(viewInCell.bounds.width)
        let height = Double(viewInCell.bounds.height)
        let n = Double(defaultEvents.count)
        
        let sidex = width / (sqrt((n * width) / height).rounded(.down)) - 1
        let side = Int(sidex.rounded(.down))
        
        
        let howManyOnRow = Int((width / Double(side)).rounded(.down))
        let space = howManyOnRow > 0 ? (Int(viewInCell.bounds.width) - howManyOnRow * side) / (howManyOnRow - 1) : 0
        
        var dx = 0, dy = 0
        var counter = 0
        
        for event in defaultEvents {
            dx = counter % howManyOnRow * side + space * (counter % howManyOnRow)
            dy = Int( ((Double(counter) / Double(howManyOnRow)).rounded(.down) * Double (side))) +
                (counter / howManyOnRow ) * space
            
            let littleView = LittleView(frame: CGRect(x: dx, y: dy, width: side, height: side))
            counter += 1
            littleView.event = event
            self.viewInCell.addSubview(littleView)
            self.colorfullViews.append(littleView)
        }
        
    }
    
    func configure(day: DayViewModel){
        self.day = day
        
        for view in colorfullViews {
            view.backgroundColor = UIColor.white
        }
        
        for event in day.events {
            let viewColoredBecauseOfEvent = colorfullViews.filter{ $0.event! == event }
            viewColoredBecauseOfEvent.first?.backgroundColor = event.color
        }
        
        dateLabel.text = day.date.dayOfTheMonth
    }
}
