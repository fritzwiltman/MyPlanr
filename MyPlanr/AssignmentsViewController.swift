//
//  AssignmentsViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class AssignmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var assignments : [(DueDate: String, Class: String, Assignment: String)] = []
    
    @IBOutlet weak var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.dataSource = self
            tableViewOutlet.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        
        // Do any additional setup after loading the view.
    }
    
    // This will be variable depending on the number of assignments on a given day
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
        
        if let myCell = cell as? AssignmentCell {
            myCell.DueDateTime.text = assignments[indexPath.row].0
            myCell.Class.text = assignments[indexPath.row].1
            myCell.Assignment.text = assignments[indexPath.row].2
            
            
        }
        return cell
    }
    
    // There should be as many sections as there are class/days in the week
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func update() {
        assignments = [("04/31/2019", "CMSC436", "Assignment 5"), ("04/31/2019", "CMSC434", "Midterm"), ("05/02/2019", "FMSC110", "In-class assignment")]
        return
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



class AssignmentCell : UITableViewCell {
    @IBOutlet weak var Class: UILabel!
    @IBOutlet weak var Assignment: UILabel!
    @IBOutlet weak var DueDateTime: UILabel!
    
}
