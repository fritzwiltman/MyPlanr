//
//  HealthKitSetup.swift
//  MyPlanr
//
//  Created by Sandro Brognara on 5/7/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitSetup {
    private enum HealthKitError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            guard let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
            let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
            let distanceWalkRun = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
            else {
                
                completion(false, HealthKitError.dataTypeNotAvailable)
                return
            }
            
            let healthKitTypesToWrite: Set<HKSampleType> = [activeEnergy, heartRate, steps, distanceWalkRun, HKObjectType.workoutType()]
            let healthKitTypesToRead: Set<HKObjectType> = [activeEnergy, heartRate, steps, distanceWalkRun, HKObjectType.workoutType()]
            
            HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) {
                (success, error) in completion(success, error)
            }
            
        } else {
            completion(false, HealthKitError.notAvailableOnDevice)
            return
        }
    }
    
    class func authorizeSleepAnalysis(completion: @escaping (Bool, Error?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            guard let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
                completion(false, HealthKitError.dataTypeNotAvailable)
                return
            }
            
            let sleepAnalysisTypesToWrite: Set<HKSampleType> = [sleepAnalysis]
            let sleepAnalysisTypesToRead: Set<HKObjectType> = [sleepAnalysis]
            
            HKHealthStore().requestAuthorization(toShare: sleepAnalysisTypesToWrite, read: sleepAnalysisTypesToRead) {
                (success, error) in completion(success, error)
            }
            
        } else {
            completion(false, HealthKitError.notAvailableOnDevice)
            return
        }
    }
    
}
