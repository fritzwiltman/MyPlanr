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
    @IBOutlet weak var AuthorizationMessageLabel: UILabel!
    
    @IBAction func getStepsAction(_ sender: Any) {
        getDistanceWalkRun()
        getStepsCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HealthKitSetup.authorizeHealthKit { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    self.AuthorizationMessageLabel.text = "HealthKit was successfully authorized on this device."
                }
                
            } else {
                let errDesc = "HealthKit authorization failed."
                
                if let e = error {
                    DispatchQueue.main.async {
                        self.AuthorizationMessageLabel.text = errDesc + e.localizedDescription
                    }
                } else {
                    DispatchQueue.main.async {
                        print(errDesc)
                    }
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
    
    private func returnToCalendarView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 0
        self.present(tabBarController, animated: true, completion: nil)
    }

}
