//
//  CalendarViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class Assigns : UITableViewCell {
    @IBOutlet weak var assignLabel: UILabel!
}

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Labels
    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var sleepHours: UILabel!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Buttons
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var assignments: UIButton!
    
    // other vars
    let date = Date()
    let format = DateFormatter()
    let classes = ["BMGT435: Team Assignment 2", "CMSC436: Project 4", "CMSC131: EXAM 2"]
    let counter = 3075
    
    // Actions -> present to other tab
    @IBAction func stepAction(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    @IBAction func sleepAction(_ sender: Any) {
        tabBarController?.selectedIndex = 3
    }
    @IBAction func assignAction(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    
    // TableView functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Assigns", for: indexPath)
        if let myCell = cell as? Assigns {
            myCell.assignLabel.text = classes[indexPath.row]
        }
        return cell
    }
    
    // other functions
    func getDay() -> String {
        format.dateFormat = "dd"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSleepActivity()
        //fetchStepCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        month.text = date.monthAsString()
        month.font = UIFont(name: "Kailasa-Bold", size: 37)
        day.text = getDay()
        day.font = UIFont(name: "Kailasa-Bold", size: 37)
        weekday.text = date.dayOfWeek()
        weekday.font = UIFont(name: "Kailasa-Bold", size: 37)
        stepCount.text = String(counter)
        stepButton.setTitle("👣", for: UIControl.State.normal)
        stepButton.layer.borderWidth = 2.5
        stepButton.layer.cornerRadius = 10.0
        stepButton.layer.shadowRadius = 2.5
        stepButton.layer.shadowOpacity = 0.5
        stepButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        stepButton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        stepButton.layer.borderColor = #colorLiteral(red: 0.5876185298, green: 0.5599239469, blue: 0.5215545297, alpha: 1)
        sleepButton.setTitle("💤", for: UIControl.State.normal)
        sleepButton.layer.borderWidth = 2.5
        sleepButton.layer.cornerRadius = 10.0
        sleepButton.layer.shadowRadius = 2.5
        sleepButton.layer.shadowOpacity = 0.5
        sleepButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        sleepButton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        sleepButton.layer.borderColor = #colorLiteral(red: 0.5876185298, green: 0.5599239469, blue: 0.5215545297, alpha: 1)
        assignments.setTitle("On the Calendar Today", for: UIControl.State.normal)
        assignments.layer.borderWidth = 2.5
        assignments.layer.cornerRadius = 7.0
        assignments.layer.shadowRadius = 2.5
        assignments.layer.shadowOpacity = 0.5
        assignments.layer.shadowOffset = CGSize(width: 5, height: 5)
        assignments.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        assignments.layer.borderColor = #colorLiteral(red: 0.5876185298, green: 0.5599239469, blue: 0.5215545297, alpha: 1)
        assignments.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
    }
    
    // HealthKit functions
    private func fetchSleepActivity() {
        HealthKitDataStore.readSleepActivtiyMostRecent() { (sleep, error) in
            if error == nil, let s = sleep {
                let start = s.startDate
                let end = s.endDate
                let interval = end.timeIntervalSince(start)
                let secondsInMinute: Double = 60
                let minutesInHour: Int = 60
                let secondsInHour: Double = 3600
                let hours = Int(interval/secondsInHour)
                let minutes = Int(interval/secondsInMinute) % minutesInHour
                
                self.sleepHours.text = "\(hours):\(minutes)"
            } else {
                self.sleepHours.text = "- - -"
            }
        }
    }
    
    private func fetchStepCount() {
        HealthKitDataStore.getStepsCount() { (steps, error) in
            if error == nil, let s = steps {
                self.stepCount.text = String(s.count)
            } else {
                self.stepCount.text = "- - -"
            }
        }
    }
    
}

// date formating 
extension Date {
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
