//
//  GoalDelegate.swift
//  Exam5
//
//  Created by Enrico Pineda on 9/30/17.
//  Copyright © 2017 Enrico Pineda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol GoalDelegate: class {
    
    func saveButton(controller: AddGoalViewController, goal: String, date: Date, from: NSIndexPath?)
    
    func doneButton(controller: FilterViewController, flip: Bool)
}
