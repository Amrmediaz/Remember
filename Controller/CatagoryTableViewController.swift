//
//  CatagoryTableViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/28/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit
import CoreData
class CatagoryTableViewController: UITableViewController {
var catogeryArray = [Catogery]()
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
load()
     
    }

    // MARK: - Table view data source
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        cell.textLabel?.text = catogeryArray[indexPath.row].name
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catogeryArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //performSegue(withIdentifier: "goToItems", sender: self)
    }
   
   
    @IBAction func addCatogery(_ sender: UIBarButtonItem) {
        var Text = UITextField()
        var catogery = Catogery()
        let alert = UIAlertController(title: "New Catogery", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter catogery name"
            Text = alertTextField
        }
        let actionAlert = UIAlertAction(title: "Add", style: .default) { (action) in
            let catogery = Catogery(context : self.context)
         catogery.name = Text.text

           self.catogeryArray.append(catogery)
            self.saveItem()
            self.load()
            //add alert
        }
      
        alert.addAction(actionAlert)
        present(alert,animated: true , completion: nil)    }
    
    //MARK: - go to items of the catogery
   
    //MARK : - Load data from core
    func load(with request : NSFetchRequest<Catogery> = Catogery.fetchRequest()){
        do {
       catogeryArray = try self.context.fetch(request)
        }catch{}
        tableView.reloadData()
    }
    
    //MARK: - Save data to core
    func saveItem() {
        // let encoders = PropertyListEncoder()
        do{
            try self.context.save()
            
            //   let data = try encoders.encode(self.elements)
            //  try data.write(to: self.filePath!)
        }catch{}
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination as! ToDoListController
        if let index = tableView.indexPathForSelectedRow {
            destinationController.selectedCatogery = catogeryArray[index.row]
        }
    }
}


