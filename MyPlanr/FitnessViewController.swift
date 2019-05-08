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
    @IBOutlet weak var AuthorizationMessageLabel: UILabel!
    
    @IBAction func getStepsAction(_ sender: Any) {
        getStepsCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func authorizeHealthKit() {
        HealthKitSetup.authorizeHealthKit { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    self.AuthorizationMessageLabel.text = "HealthKit was successfully authorized on this device."
                }
                
            } else {
                let errDesc = "HealthKit authorization failed."
                
                guard let e = error else {
                    DispatchQueue.main.async {
                        self.AuthorizationMessageLabel.text = errDesc
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.AuthorizationMessageLabel.text = errDesc + e.localizedDescription
                }
                return
            }
        }
    }
    
    private func getStepsCount() {
        HealthKitDataStore.getStepsCount()
    }

}
