//
//  AssignmentsViewController.swift
//  MyPlanr
//
//  Created by Fritz on 4/30/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit

class AssignmentCell : UITableViewCell {
    @IBOutlet weak var CourseAssignmentLabel: UILabel!
    @IBOutlet weak var DueDateLabel: UILabel!
}

class AssignmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayViewControllerDelegate {
    
    var allAssignments = Assignments()
    var selectedIndex = 0
    
    @IBOutlet weak var EmptyListLabel: UILabel!
    @IBOutlet weak var AddAssignment: UIBarButtonItem!
    
    @IBOutlet weak var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.dataSource = self
            tableViewOutlet.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (allAssignments.assignments.isEmpty) {
            EmptyListLabel.text = "You currently have no assignments."
        }
        tableViewOutlet.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // Segue to add a new assignment through the navigation bar add item
    @IBAction func AddAssignmentAction(_ sender: Any) {
        self.performSegue(withIdentifier: "assignmentSegue", sender: self)
    }
    
    
    // There is only one section in this table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // The number of rows in the table based off the number of assignments created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAssignments.countAssignments()
    }
    
    // Adding each assignment to the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
        
        if let myCell = cell as? AssignmentCell {
            myCell.DueDateLabel.text = allAssignments.assignments[indexPath.row].dueDateTime
            myCell.CourseAssignmentLabel.text = "\(allAssignments.assignments[indexPath.row].course): \(allAssignments.assignments[indexPath.row].name)"
        }
        return cell
    }
    
    // Removes gray color of row after it is selected
    // Shows details on clicked assignment
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Removes gray
        
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "assignmentDetailsSegue", sender: self)
    }
    
    // Allows for deletion of assignment with swipe left gesture
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allAssignments.assignments.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    // Preparing the segue to add assignment
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        if(segue.identifier == "assignmentDetailsSegue") {
            let detailsVC = segue.destination as! DetailsViewController
            let index = tableViewOutlet.indexPathForSelectedRow?.row
            detailsVC.assignment = allAssignments.assignments[index ?? 0]
        }
        
        if(segue.identifier == "assignmentSegue"){
            let displayVC = segue.destination as! NewAssignmentViewController
            displayVC.delegate = self
        }
    }
    
    // Preparing segue to show details of assignment

    
    // Allows for manipulation of new assignment made in add assignments VC
    func doSomethingWith(data: Assignment) {
        allAssignments.addAssignment(assignment: data)
        EmptyListLabel.text = ""
        update()
    }
    
    // After assignment is added, update must be called to refresh table
    func update() {
        self.tableViewOutlet.reloadData()
    }
}
