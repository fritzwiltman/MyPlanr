//
//  DetailsViewController.swift
//  MyPlanr
//
//  Created by Fritz on 5/13/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var AssignmentNameCourseOutlet: UILabel!
    @IBOutlet weak var DateOutlet: UILabel!
    @IBOutlet weak var NotesOutlet: UITextView!
    
    var assignment : Assignment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AssignmentNameCourseOutlet.text = "\(assignment!.name) for \(assignment!.course)"
        DateOutlet.text = assignment!.dueDateTime
        NotesOutlet.text = assignment?.notes
        NotesOutlet.layer.borderColor = UIColor.black.cgColor
        NotesOutlet.layer.borderWidth = 3.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
