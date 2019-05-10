//
//  SleepActivityViewController.swift
//  MyPlanr
//
//  Created by Sandro Brognara on 5/9/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation
import UIKit

class SleepActivityViewController: UIViewController {
    
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var StartDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //make a single changed date for both date pickers
    @IBAction func changedStartDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h:mm a    MMMM d"
        
        StartDateLabel.text = dateFormatter.string(from: sender.date)
    }
    
}
