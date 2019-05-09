//
//  HealthKitDataStore.swift
//  MyPlanr
//
//  Created by Sandro Brognara on 5/7/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitDataStore {
    
    class func getStepsCount() {
        let stepCountType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let stepsQuery = HKSampleQuery(sampleType: stepCountType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
            (stepsQuery, result, error) in
            
            DispatchQueue.main.async {
                guard let steps = result?.last as? HKQuantitySample else {
                    print("Error fetching step count.")
                    return
                }
                print("\(steps) steps taken, recorded at \(steps.endDate)")
            }
        }
        HKHealthStore().execute(stepsQuery)
    }
    
    class func getDistanceWalkRun() {
        let distanceWalkRunType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        
        let distanceQuery = HKSampleQuery(sampleType: distanceWalkRunType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
            (distanceQuery, result, error) in
            
            DispatchQueue.main.async {
                guard let distance = result?.last as? HKQuantitySample else {
                    print("Error fetching walking/running distance.")
                    return
                }
                print(distance)         //distance or distance.count? Also is a sample the total distance for the day?
            }
        }
        HKHealthStore().execute(distanceQuery)
        
    }
    
}
