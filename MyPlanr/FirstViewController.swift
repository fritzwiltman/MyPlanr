//
//  FirstViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/28/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var NewButton: UIButton!
    
    @IBAction func ButtonAction(_ sender: Any) {
        print("Test")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("App loaded.")
    }


}

