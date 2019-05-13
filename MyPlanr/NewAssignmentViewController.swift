//
//  NewAssignmentViewController.swift
//  MyPlanr
//
//  Created by Fritz on 5/12/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import UIKit
//import Eureka

protocol DisplayViewControllerDelegate : NSObjectProtocol {
    func doSomethingWith(data: Assignment)
}

class NewAssignmentViewController: UIViewController {
    
    weak var delegate : DisplayViewControllerDelegate?
    var assignment = Assignment(name: "", course: "", dueDateTime: "", color: UIColor.white, notes: "")
    var date : String = ""

    @IBOutlet weak var CancelOutlet: UIBarButtonItem!
    @IBOutlet weak var SaveOutlet: UIBarButtonItem!
    @IBOutlet weak var DateTimeTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var CourseTextField: UITextField!
    @IBOutlet weak var AssignmentTypeTextField: UITextField!
    @IBOutlet weak var NotesTextField: UITextView!
    
    private var datePicker : UIDatePicker?
    private var assignmentPicker : UIPickerView?
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewAssignmentViewController.viewTapped(gestureRecognizer:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up due date/time picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(NewAssignmentViewController.dateChanged(datePicker:)), for: .valueChanged)
        DateTimeTextField.inputView = datePicker
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func SaveAction(_ sender: UIBarButtonItem) {
        // save this information
        assignment.name = getDescription()
        assignment.course = getCourse()
        assignment.dueDateTime = date
        assignment.notes = NotesTextField.text
        delegate?.doSomethingWith(data: assignment)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDescription() -> String {
        let description = DescriptionTextField.text!
        return description
    }
    
    func getCourse() -> String {
        let course = CourseTextField.text!
        return course
    }
    
//    TODO
    func getColor() -> UIColor {
        return UIColor.blue
    }
    
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        date = dateFormatter.string(from: datePicker.date)
        DateTimeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
}

