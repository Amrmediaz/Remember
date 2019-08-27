//
//  ViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/27/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    var elements = [Item]()
    
    let userDefault = UserDefaults.standard
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        // add DataPresitance
  
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    //add elements to cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row].itemName
        cell.accessoryType = elements[indexPath.row].itemIsChecked ? .none : .checkmark

        return cell
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    //selected row method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let item = elements[indexPath.row].itemIsChecked
        let cell =  tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = item ? .none : .checkmark
      
        
        elements[indexPath.row].itemIsChecked = !item
     
        tableView.deselectRow(at: indexPath, animated: true)
        saveItemByEncoding()
    }
    //MARK - Add new items
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
        
        var textFeleld = UITextField()
        let alert = UIAlertController(title: "New Item", message: "Add new Item to task list", preferredStyle: .alert)
       
        alert.addTextField {(alertTextField) in alertTextField.placeholder = "Add new Item"
        // put text which entered by user to global variable textFeleld
            textFeleld = alertTextField
            
        }
       //action button of alert dialog
        let action=UIAlertAction(title: "Add", style:.default) { (action) in
            let itennewb=Item()

            
            itennewb.itemName=textFeleld.text!
            self.elements.append(itennewb)
self.saveItemByEncoding()
            //
        }
        alert.addAction(action)
        present(alert,animated: true , completion: nil)
    }
    func saveItemByEncoding() {
        let encoders = PropertyListEncoder()
        do{
            let data = try encoders.encode(self.elements)
            try data.write(to: self.filePath!)
        }catch{}
        self.tableView.reloadData()
    }
    func loadData(){
        do {
        let data = try Data(contentsOf: filePath!)
            let decode = PropertyListDecoder()
            elements = try decode.decode([Item].self, from: data)
        }catch{}
    }
}

