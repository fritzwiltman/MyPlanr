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
        authorizeHealthKit()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func authorizeHealthKit() {
        HealthKitSetup.authorizeHealthKit { (success, error) in
            
            if success {
                print("HealthKit was successfully authorized on this device.")
                
            } else {
                let errDesc = "HealthKit authorization failed."
                
                guard let e = error else {
                    print(errDesc)
                    return
                }
                print(errDesc + e.localizedDescription)
                return
            }
        }
    }

}
