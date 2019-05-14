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
    
    class func getStepsCount(completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        let stepCountType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let stepsQuery = HKSampleQuery(sampleType: stepCountType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) {
            (stepsQuery, result, error) in
            
            DispatchQueue.main.async {
                if error == nil {
                    guard let steps = result?.last as? HKQuantitySample else {
                        completion(nil, error)
                        return
                    }
                    completion(steps, nil)
                }
            }
        }
        HKHealthStore().execute(stepsQuery)
    }
    
    class func getDistanceWalkRun(completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        let distanceWalkRunType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let distanceQuery = HKSampleQuery(sampleType: distanceWalkRunType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) {
            (distanceQuery, result, error) in
            
            DispatchQueue.main.async {
                if error == nil {
                    guard let distance = result?.last as? HKQuantitySample else {
                        completion(nil, error)
                        return
                    }
                    completion(distance, nil)
                }
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
                DispatchQueue.main.async {
                    if error == nil {
                        guard let sleep = result?.last as? HKCategorySample else {
                            completion(nil, error)
                            return
                        }
                        completion(sleep, nil)
                    }
                }
            }
            HKHealthStore().execute(sleepQuery)
        }
    }
    
    class func readSleepActivityPastWeek(completion: @escaping ([HKCategorySample]?, Error?) -> Void) {
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            let now = Date()
            let startDate = Calendar.current.date(byAdding: DateComponents(day: -7), to: now)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let sleepQuery = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 7, sortDescriptors: [sortDescriptor]) {
                (sleepQuery, result, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        guard let sleep = result as? [HKCategorySample] else {
                            completion(nil, error)
                            return
                        }
                        completion(sleep, nil)
                    }
                }
            }
            HKHealthStore().execute(sleepQuery)
        }
    }
    
    class func saveWorkout(newWorkout: Workout, completion: @escaping (Bool, Error?) -> Void) {
        let healthStore = HKHealthStore()
        let workoutConfig = HKWorkoutConfiguration()
        workoutConfig.activityType = .other
        
        
        let builder = HKWorkoutBuilder(healthStore: healthStore, configuration: workoutConfig, device: .local())
        builder.beginCollection(withStart: newWorkout.startDate) { (success, error) in
            guard success else {
                completion(false, error)
                return
            }
            
        }
        
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
                completion(false, nil)
                return
        }
        
        let quantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: newWorkout.totalCaloriesBurned)
        
        let workoutSample = HKCumulativeQuantitySeriesSample(type: quantityType, quantity: quantity, start: newWorkout.startDate, end: newWorkout.endDate)
        
        builder.add([workoutSample]) { (success, error) in
            guard success else {
                completion(false, error)
                return
            }
            builder.endCollection(withEnd: newWorkout.endDate) { (success, error) in
                guard success else {
                    completion(false, error)
                    return
                }
                builder.finishWorkout { (_, error) in
                    let success = error == nil
                    completion(success, error)
                }
            }
        }
    }
    
    class func loadWorkout(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let predicates = NSCompoundPredicate(andPredicateWithSubpredicates: [
                HKQuery.predicateForWorkouts(with: .other),
                HKQuery.predicateForObjects(from: .default())
            ])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        
        let workoutQuery = HKSampleQuery(sampleType: .workoutType(), predicate: predicates, limit: 0, sortDescriptors: [sortDescriptor]) { (workoutQuery, result, error) in
            DispatchQueue.main.async {
                if error == nil {
                    guard let workout = result as? [HKWorkout] else {
                        completion(nil, error)
                        return
                    }
                    completion(workout, nil)
                }
            }
        }
        HKHealthStore().execute(workoutQuery)
    }
    
}
