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
    
    @IBOutlet weak var AddAssignment: UIBarButtonItem!
    @IBOutlet weak var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.dataSource = self
            tableViewOutlet.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("All assignments: \(allAssignments.assignments)")
        print("\n TEST \n")
        update()
        tableViewOutlet.tableFooterView = UIView(frame: CGRect.zero)
    }

    func doSomethingWith(data: Assignment) {
        allAssignments.addAssignment(assignment: data)
        self.tableViewOutlet.reloadData()
    }
    
    @IBAction func AddAssignmentAction(_ sender: Any) {
        self.performSegue(withIdentifier: "assignmentSegue", sender: self)
    }
    
    
    // There should be as many sections as there are class/days in the week
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // This will be variable depending on the number of assignments on a given day
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAssignments.countAssignments()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
        
        if let myCell = cell as? AssignmentCell {
            myCell.DueDateLabel.text = allAssignments.assignments[indexPath.row].dueDateTime
            myCell.CourseAssignmentLabel.text = "\(allAssignments.assignments[indexPath.row].course): \(allAssignments.assignments[indexPath.row].name)"
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "assignmentSegue"){
            let displayVC = segue.destination as! NewAssignmentViewController
            displayVC.delegate = self
        }
    }
    
    func update() {
        self.tableViewOutlet.reloadData()
    }
}
