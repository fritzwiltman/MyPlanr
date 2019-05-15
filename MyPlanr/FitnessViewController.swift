//
//  FitnessViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class FitnessViewController: UIViewController {

    @IBAction func ButtonAction(_ sender: Any) {
        getStepsCount()
        getDistanceWalkRun()
    }
    
//    @IBAction func getStepsAction(_ sender: Any) {
//        getDistanceWalkRun()
//        getStepsCount()
//    }
    
    @IBOutlet weak var StepsLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFitnessActivity))
        
        HealthKitSetup.authorizeHealthKit { (success, error) in
            
            if !success {
                let errDesc = "HealthKit authorization failed."
                
                if let e = error {
                    print(errDesc + e.localizedDescription)
                } else {
                    print(errDesc)
                }
                self.returnToCalendarView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStepsCount()
        getDistanceWalkRun()
    }
    
    private func getStepsCount() {
        HealthKitDataStore.getStepsCount() { (steps, error) in
            DispatchQueue.main.async {
                if error == nil, let s = steps {
                    self.StepsLabel.text = "\(s.count) steps"
                } else {
                    self.StepsLabel.text = "- - - steps"
                }
            }
        }
    }
    
    private func getDistanceWalkRun() {
        HealthKitDataStore.getDistanceWalkRun() { (distance, error) in
            DispatchQueue.main.async {
                if error == nil, let d = distance {
                    self.DistanceLabel.text = "\(d.count) mi"
                } else {
                    self.DistanceLabel.text = "- - - mi"
                }
            }
        }
    }
    
    @objc private func addFitnessActivity(sender: Any) {
        self.performSegue(withIdentifier: "fitness", sender: self)
    }
    
    private func returnToCalendarView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 0
        self.present(tabBarController, animated: true, completion: nil)
    }

}
