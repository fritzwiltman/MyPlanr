//
//  SleepViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit
import HealthKit

class SleepViewController: UIViewController {

    @IBAction func ButtonAction(_ sender: Any) {
        fetchSleepActivityMostRecent()
        fetchSleepActivityPastWeek()
    }
    
    @IBOutlet weak var YesterdayLabel: UILabel!
    @IBOutlet weak var TableView: UITableView!
    
    private var sleepData: [HKCategorySample]?
    private var sleepCellIdentifier = "SleepDataCell"
    
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
        fetchSleepActivityPastWeek()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSleepActivityPastWeek()
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
                
//                let secondsInMinute: Double = 60
//                let minutesInHour: Int = 60
//                let secondsInHour: Double = 3600
//                let hours = Int(interval!/secondsInHour)
//                let minutes = Int(interval!/secondsInMinute) % minutesInHour
                let (hours, minutes) = self.formatHoursMins(i: interval ?? 0)
                displayString = "\(hours) hrs \(minutes) mins"
            }
            DispatchQueue.main.async {
                self.YesterdayLabel.text = displayString
            }
        }
    }
    
    private func fetchSleepActivityPastWeek() {
//        HealthKitDataStore.readSleepActivityPastWeek() { (activity, error) in
//            if error == nil {
//                for a in activity ?? [] {
//                    let start = a.startDate
//                    let end = a.endDate
//                    let interval = end.timeIntervalSince(start)
//                    let (hours, minutes) = self.formatHoursMins(i: interval)
//
//                    print("From \(start) to \(end) -- \(hours):\(minutes)")
//                }
//            }
//        }
        
        HealthKitDataStore.readSleepActivityPastWeek() { (activity, error) in
            self.sleepData = activity
            self.TableView.reloadData()
        }
    }
    
    private func formatHoursMins(i: TimeInterval) -> (Int, Int) {
        let secondsInMinute: Double = 60
        let minutesInHour: Int = 60
        let secondsInHour: Double = 3600
        let hours = Int(i/secondsInHour)
        let minutes = Int(i/secondsInMinute) % minutesInHour
        
        return (hours, minutes)
    }
    
    func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return sleepData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sleepData = sleepData {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                sleepCellIdentifier, for: indexPath)
            
            let sleep = sleepData[indexPath.row]
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .medium
            cell.textLabel?.text = "\(formatter.string(from: sleep.startDate)) to \(formatter.string(from: sleep.endDate))"
            
    //        if let caloriesBurned =
    //            workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
    //            let formattedCalories = String(format: "CaloriesBurned: %.2f",
    //                                           caloriesBurned)
    //
    //            cell.detailTextLabel?.text = formattedCalories
    //        } else {
    //            cell.detailTextLabel?.text = nil
    //        }
            
            let (hours, mins) = formatHoursMins(i: sleep.startDate.timeIntervalSince(sleep.endDate))
            cell.detailTextLabel?.text = "\(hours) hrs \(mins) mins"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                sleepCellIdentifier, for: indexPath)
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
            
            return cell
        }
    }
}
