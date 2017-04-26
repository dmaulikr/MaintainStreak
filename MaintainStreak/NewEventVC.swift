//
//  NewEventVC.swift
//  MaintainStreak
//
//  Created by Laura Calinoiu on 26/04/2017.
//  Copyright © 2017 Laura Calinoiu. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var colorView: UIView! {
        didSet {
            
            colorView.backgroundColor = UIColor(red: CGFloat(randomInt(min: 0, max: 255))/255,
                                                green: CGFloat(randomInt(min: 0, max: 255))/255,
                                                blue: CGFloat(randomInt(min: 0, max: 255))/255, alpha: 1)
        }
    }
    var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let name = eventNameTextField.text, let color = colorView.backgroundColor else { return }
        dataProvider.addEvent(name: name, color: color)
        dismiss(animated: true, completion: nil)
    }

}

func randomInt(min: Int, max:Int) -> Int {
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}
