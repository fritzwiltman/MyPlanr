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
    }
    
    @IBAction func getStepsAction(_ sender: Any) {
        getDistanceWalkRun()
        getStepsCount()
    }
    
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
    
    private func getStepsCount() {
        HealthKitDataStore.getStepsCount()
    }
    
    private func getDistanceWalkRun() {
        HealthKitDataStore.getDistanceWalkRun()
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
