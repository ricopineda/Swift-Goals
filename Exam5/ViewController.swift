//
//  ViewController.swift
//  Exam5
//
//  Created by Enrico Pineda on 9/30/17.
//  Copyright © 2017 Enrico Pineda. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, GoalDelegate {
    
    var goals = [Goal]()
    
    let mOc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath)
        cell.textLabel?.text = goals[indexPath.row].text!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = formatter.string(from: (goals[indexPath.row].date)!)
        
        let myDate = formatter.date(from: date)
        formatter.dateFormat = "MM /dd /yyyy"
        let newDate = formatter.string(from: myDate!)
        
        cell.detailTextLabel?.text = newDate
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete =  UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let deleteAlert = UIAlertController(title: "Warning", message: "Remove Item.", preferredStyle: UIAlertControllerStyle.alert)

            deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                let item = self.goals[indexPath.row]
                self.mOc.delete(item)
                do{
                    try self.mOc.save()
                } catch {
                    print("\(error)")
                    
                }
                self.goals.remove(at: indexPath.row)
                tableView.reloadData()
            }))

            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))

            self.present(deleteAlert, animated: true, completion: nil)

        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "Edit", sender: indexPath)
        }
        edit.backgroundColor = UIColor.blue
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            // addvcode to delete cell and add to completed list
        }

        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add"{
            let navController = segue.destination as! UINavigationController
            let addGoal = navController.topViewController as! AddGoalViewController
            addGoal.delegate = self
        }
        else if segue.identifier == "Edit"{
            let navController = segue.destination as! UINavigationController
            let addGoal = navController.topViewController as! AddGoalViewController
            addGoal.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let current = goals[indexPath.row]
            addGoal.goal = current.text!
            addGoal.date = current.date
            addGoal.indexPath = indexPath
            
        }
        
    }
    
    func saveButton(controller: AddGoalViewController, goal: String, date: Date, from: NSIndexPath?) {
        if let index = from {
            let item = goals[index.row]
            item.text = goal
            item.date = date as Date
        }
        else{
            let item  = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: mOc) as! Goal
            item.text = goal
            item.date = date as Date
            goals.append(item)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
        do {
            try mOc.save()
        }catch {
            print("\(error)")
        }

    }
    
    func doneButton(controller: FilterViewController, flip: Bool) {
        dismiss(animated: true, completion: nil)
        // add code to flip displayed table
        print(flip)
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        // filtering date in ascending order
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        do{
            let results = try mOc.fetch(request)
            goals = results as! [Goal]
        } catch {
            print("\(error)")
        }
    }
    
}

