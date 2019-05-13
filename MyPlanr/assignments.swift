//
//  assignments.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation
import UIKit

struct Assignment {
    var name : String
    var course : String
    var dueDateTime : String
    var color : UIColor
    var notes : String
}


class Assignments {
    var assignments : [Assignment] = []

    init() {
        assignments = []
    }
    
    func countAssignments() -> Int {
        return assignments.count
    }
    
    func addAssignment(assignment : Assignment) {
        assignments.append(assignment)
    }
}
