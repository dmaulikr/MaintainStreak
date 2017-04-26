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
    @IBOutlet weak var colorView: UIView!
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
