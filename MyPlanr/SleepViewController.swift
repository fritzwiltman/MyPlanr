//
//  SleepViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {

    @IBAction func ButtonAction(_ sender: Any) {
        fetchSleepActivityMostRecent()
    }
    
    @IBOutlet weak var YesterdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSleepActivity))
        
        HealthKitSetup.authorizeSleepAnalysis { (success, error) in
            
            if !success {
                
                let errDesc = "HealthKit authorization failed."

                if let e = error {
                    DispatchQueue.main.async {
                        print(errDesc + e.localizedDescription)
                    }
                } else {
                    DispatchQueue.main.async {
                        print(errDesc)
                    }
                }
                self.returnToCalendarView()
            }
        }
        
        fetchSleepActivityMostRecent()
    }
    
    private func returnToCalendarView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 0
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    @objc private func addSleepActivity(sender: Any) {
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    private func fetchSleepActivityMostRecent() {
        HealthKitDataStore.readSleepActivtiyMostRecent() { (activity, error) in
            var displayString = "- - -"
            
            if error == nil {
                let start = activity?.startDate
                let end = activity?.endDate
                let interval = end?.timeIntervalSince(start!)
                
                let secondsInMinute: Double = 60
                let minutesInHour: Int = 60
                let secondsInHour: Double = 3600
                let hours = Int(interval!/secondsInHour)
                let minutes = Int(interval!/secondsInMinute) % minutesInHour
                displayString = "\(hours) hrs \(minutes) mins"
            }
            DispatchQueue.main.async {
                self.YesterdayLabel.text = displayString
            }
        }
    }
    
}
