//
//  NewWorkoutViewController.swift
//  MyPlanr
//
//  Created by Sandro Brognara on 5/14/19.
//  Copyright © 2019 Fritz Gerald Wiltman. All rights reserved.
//

import Foundation
import UIKit

class NewWorkoutViewController: UIViewController {
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var ToggleTimer: UIButton!
    
    @IBAction func enterCalsRate(_ sender: Any) {
        
    }
    
    @IBAction func toggleTime(_ sender: Any) {
        if state == .active {
            state = .stopped
            activated = true
        } else {
            state = .active
        }
        startDate = Date()
        updateTimer()
    }
    
    enum WorkoutState {
        case inactive
        case active
        case stopped
    }
    
    private var timer: Timer!
    private var startDate = Date()
    private var currentTime: TimeInterval = 0.0
    private var activated: Bool = false
    private var state: WorkoutState = .inactive
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.updateTimer()
        })
        
        self.navigationItem.title = "Add Workout"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveWorkoutActivity))
    }
    
    private func updateTimer() {
        let timerFormat = DateComponentsFormatter()
        timerFormat.unitsStyle = .positional
        timerFormat.allowedUnits = [.minute, .second]
        timerFormat.zeroFormattingBehavior = [.pad]
        
        switch state {
            
        case .active:
            if activated {
                TimerLabel.text = timerFormat.string(from: currentTime)
                let time = Date().timeIntervalSince(startDate)
                currentTime = time
                TimerLabel.text = timerFormat.string(from: time)
            } else {
                let time = Date().timeIntervalSince(startDate)
                currentTime = time
                TimerLabel.text = timerFormat.string(from: time)
            }
            
        case .stopped:
            TimerLabel.text = timerFormat.string(from: currentTime)
            
        default:
            TimerLabel.text = "0:00"
            
        }
    }
    
    @objc private func saveWorkoutActivity(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
