//
//  ViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/27/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
let elements = ["eggs","chease","mango"]
    override func viewDidLoad() {
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
}

