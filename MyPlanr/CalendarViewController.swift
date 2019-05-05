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
    
    // Idea: list the assignments and then have them appear in color of that class
    // need to get list of classes and the colors used from assignments tab
    // need list of assignemnts for current date (maybe only what still needs to be done)
    // need step and sleep count
    
    // what if for the assigments tab there is a "other" or "personal" color for non-school things
    
    // Labels
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var sleepHours: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Buttons
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var assignments: UIButton!
    
    // other vars
    let date = Date()
    let format = DateFormatter()
    let classes = [("Team Assignment 2","cs3"), ("Project 4","cs1"), ("EXAM 2","cs2")]
    let counter = 3075
    let hours = 7
    
    // Actions -> present to other tab?
    @IBAction func stepAction(_ sender: Any) {
        print("step")
    }
    @IBAction func sleepAction(_ sender: Any) {
        print("sleep")
    }
    @IBAction func assignAction(_ sender: Any) {
        print("assign")
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
            myCell.assignLabel.text = classes[indexPath.row].0
            myCell.assignLabel.textColor = getColor(course: classes[indexPath.row].1)
        }
        return cell
    }
    
    // other functions
    func getDay() -> String {
        format.dateFormat = "dd"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    func getColor(course: String) -> UIColor {
        if course == "cs1"{
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        else if course == "cs2" {
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        else if course == "cs3" {
            return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        month.text = date.monthAsString()
        day.text = getDay()
        stepCount.text = String(counter)
        sleepHours.text = String(hours)
        stepButton.setTitle("👣", for: UIControl.State.normal)
        sleepButton.setTitle("💤", for: UIControl.State.normal)
        assignments.setTitle("On the Calendar Today", for: UIControl.State.normal)
        assignments.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
    }
    
}

extension Date {
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
}
