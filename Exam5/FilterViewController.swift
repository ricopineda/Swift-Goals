//
//  FilterViewController.swift
//  Exam5
//
//  Created by Enrico Pineda on 9/30/17.
//  Copyright © 2017 Enrico Pineda. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var delegate: GoalDelegate?
    var flip: Bool?


    @IBOutlet weak var flipSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        delegate?.doneButton(controller: self, flip: flipSwitch.isOn)

    }
    
    @IBAction func switchUsed(_ sender: UISwitch) {
    }
}
