//
//  ViewController.swift
//  PedometerTest
//
//  Created by Sandro Brognara on 4/16/19.
//  Copyright © 2019 Sandro Brognara. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()

    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var stepsCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startUpdating()
    }

    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in

            guard let activity = activity else { return }
            print("START TRACKING ACTIVITY TYPE")
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityTypeLabel.text = "Walking"
                    print("Walking -----------")
                } else if activity.stationary {
                    self?.activityTypeLabel.text = "Stationary"
                    print("Stationary -----------")
                } else if activity.running {
                    self?.activityTypeLabel.text = "Running"
                    print("Running -----------")
                } else if activity.automotive {
                    self?.activityTypeLabel.text = "Automotive"
                    print("Driving -----------")
                }
            }
        }
    }

    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }

            DispatchQueue.main.async {
                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }

    private func startUpdating() {
        print("starting updating...")
        if CMMotionActivityManager.isActivityAvailable() {
            print("activity YES")
            startTrackingActivityType()
        } else {
            print("activity not available")
        }

        if CMPedometer.isStepCountingAvailable() {
            print("step counting YES")
            startCountingSteps()
        } else {
            print("step counting not available")
        }
    }
}


