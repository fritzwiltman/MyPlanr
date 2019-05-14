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
    
    class func writeSleepActivity(start: Date, end: Date) {
        let healthStore = HKHealthStore()
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            let sample = HKCategorySample(type: sleepType, value: HKCategoryValueSleepAnalysis.asleep.rawValue, start: start, end: end)
            
            healthStore.save(sample) { (success, error) in
                guard let e = error else {
                    print("Successfully wrote sleep data")
                    return
                }
                
                print("Error writing sleep data: \(e)")
            }
        }
    }
    
    class func readSleepActivtiyMostRecent(completion: @escaping (HKCategorySample?, Error?) -> Void) {
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let sleepQuery = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) {
                (sleepQuery, result, error) in
                
                guard let sleep = result?.last as? HKCategorySample else {
                    completion(nil, error)
                    return
                }
                completion(sleep, nil)
                
            }
            HKHealthStore().execute(sleepQuery)
        }
    }
    
    class func readSleepActivityPastWeek(completion: @escaping (HKCategorySample?, Error?) -> Void) {
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            let now = Date()
            let startDate = Calendar.current.date(byAdding: DateComponents(day: -7), to: now)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let sleepQuery = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 7, sortDescriptors: [sortDescriptor]) {
                (sleepQuery, result, error) in
                
                print(result)
                
            }
        }
    }
    
}
