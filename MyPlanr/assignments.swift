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
    var assignmentType : AssignmentType
    var course : Course
    var dueDate : DateComponents // Might have to change this to string MM/DD/YYYY
    var notes : String
}

struct Course {
    var name : String
    var color : UIColor
}

enum AssignmentType : CaseIterable {
    case homework, test, study, read, paper, presentation, project, lab, final, midterm, quiz, other
}

class Assignments {
    var assignments : [DateComponents : Assignment]
    
    init() {
        assignments = [:]
    }
    
    func newAssignment(nm : String, assignType : AssignmentType, crs : Course, date : DateComponents, nts : String) {
        Assignment(name: nm, assignmentType: assignType, course: crs, dueDate: date, notes: nts)
        
    }
}
