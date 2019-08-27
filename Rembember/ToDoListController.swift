//
//  ViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/27/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    var elements = ["eggs","chease","mango"]
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        // add DataPresitance
        if userDefault.array(forKey: "array") != nil {
            elements = userDefault.array(forKey: "array") as! [String] }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row]
        return cell
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    //selected row method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(elements[indexPath.row])
        if
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new items
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        var textFeleld = UITextField()
        let alert = UIAlertController(title: "New Item", message: "Add new Item to task list", preferredStyle: .alert)
        alert.addTextField {(alertTextField) in alertTextField.placeholder = "Add new Item"
        textFeleld = alertTextField
        }
        let action=UIAlertAction(title: "Add", style:.default) { (action) in
           self.elements.append(textFeleld.text!)
            self.userDefault.set(self.elements, forKey: "array")
            self.tableView.reloadData()
            //
        }
        alert.addAction(action)
        present(alert,animated: true , completion: nil)
    }
}

