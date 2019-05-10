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
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var EndDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Sleep"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveSleepActivity))
    }
    
    @IBAction func changedDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h:mm a    MMMM d"
        
        switch sender.tag {
        case 0:
            StartDateLabel.text = dateFormatter.string(from: sender.date)
        case 1:
            EndDateLabel.text = dateFormatter.string(from: sender.date)
        default:
            return
        }
    }
    
    @objc private func saveSleepActivity(sender: Any) {
        print("Start = \(StartDatePicker.date)")
        print("End = \(EndDatePicker.date)")
        HealthKitDataStore.writeSleepActivity(start: StartDatePicker.date, end: EndDatePicker.date)
        self.navigationController?.popViewController(animated: true)
    }
    
}
