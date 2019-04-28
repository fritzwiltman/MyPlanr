//
//  model.swift
//  PedometerTest
//
//  Created by Sandro Brognara on 4/16/19.
//  Copyright © 2019 Sandro Brognara. All rights reserved.
//

import Foundation
import CoreMotion

//class Pedometer {
//    private let activityManager = CMMotionActivityManager()
//    private let pedometer = CMPedometer()
//
//    private func startTrackingActivityType() {
//        activityManager.startActivityUpdates(to: OperationQueue.main) {
//            [weak self] (activity: CMMotionActivity?) in
//
//            guard let activity = activity else { return }
//            DispatchQueue.main.async {
//                if activity.walking {
//                    self?.activityTypeLabel.text = "Walking"
//                } else if activity.stationary {
//                    self?.activityTypeLabel.text = "Stationary"
//                } else if activity.running {
//                    self?.activityTypeLabel.text = "Running"
//                } else if activity.automotive {
//                    self?.activityTypeLabel.text = "Automotive"
//                }
//            }
//        }
//    }
//
//    private func startCountingSteps() {
//        pedometer.startUpdates(from: Date()) {
//            [weak self] pedometerData, error in
//            guard let pedometerData = pedometerData, error == nil else { return }
//
//            DispatchQueue.main.async {
//                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
//            }
//        }
//    }
//
//    private func startUpdating() {
//        if CMMotionActivityManager.isActivityAvailable() {
//            startTrackingActivityType()
//        }
//
//        if CMPedometer.isStepCountingAvailable() {
//            startCountingSteps()
//        }
//    }
//}
