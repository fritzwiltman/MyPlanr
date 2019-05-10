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
        HealthKitDataStore.readSleepActivtiy()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSleepActivity))
        
        HealthKitSetup.authorizeSleepAnalysis { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    print("Sleep analysis was successfully authorized")
                }
                
            } else {
                
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
    
}
