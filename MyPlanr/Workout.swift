//
//  Workout.swift
//  MyPlanr
//
//  Created by Sandro Brognara on 5/13/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation

struct Workout {
    var startDate: Date
    var endDate: Date
    var caloriesPerHour: Double
    
    init(start: Date, end: Date, cals: Double) {
        startDate = start
        endDate = end
        caloriesPerHour = cals
    }
    
    var workoutDuration: TimeInterval {
        return endDate.timeIntervalSince(startDate)
    }
    
    var totalCaloriesBurned: Double {
        return caloriesPerHour * (workoutDuration/3600)
    }
}
