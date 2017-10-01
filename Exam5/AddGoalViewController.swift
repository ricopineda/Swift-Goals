//
//  AddGoalViewController.swift
//  Exam5
//
//  Created by Enrico Pineda on 9/30/17.
//  Copyright © 2017 Enrico Pineda. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UIViewController {
    
    var delegate: GoalDelegate?
    var goal: String?
    var date: Date?
    var indexPath: NSIndexPath?
    
    
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel.text = goal
        if let xdate = date{
            datePicker.date = xdate
        }

    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.saveButton(controller: self, goal: goalLabel.text!, date: datePicker.date, from: indexPath)
    }
    

}
