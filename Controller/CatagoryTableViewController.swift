//
//  CatagoryTableViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/28/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
class CatagoryTableViewController: UITableViewController {
    var catogeryArray : Results<Cateagory>?
    let catogery = Cateagory()
let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
   load()
    }

    // MARK: - Table view data source
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        cell.textLabel?.text = catogeryArray?[indexPath.row].name ?? "hi"
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catogeryArray?.count ?? 1   }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //performSegue(withIdentifier: "goToItems", sender: self)
    }
   
   
    @IBAction func addCatogery(_ sender: UIBarButtonItem) {
        var Text = UITextField()
       // var catogery = Cateagory()
        let alert = UIAlertController(title: "New Catogery", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter catogery name"
            Text = alertTextField
        }
        let actionAlert = UIAlertAction(title: "Add", style: .default) { (action) in
       self.catogery.name = Text.text!

            self.saveItem()
          //  self.load()
            //add alert
        }
      
        alert.addAction(actionAlert)
        present(alert,animated: true , completion: nil)    }
    
    //MARK: - go to items of the catogery
   
    //MARK : - Load data from core
    func load(){

catogeryArray = realm.objects(Cateagory.self)
        tableView.reloadData()}
//    }
    
    //MARK: - Save data to core
    func saveItem() {
        do{
       try realm.write {
            realm.add(catogery)
            }}catch {}
        do{
            
            //   let data = try encoders.encode(self.elements)
            //  try data.write(to: self.filePath!)
        }catch{}
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination as! ToDoListController
        if let index = tableView.indexPathForSelectedRow {
            destinationController.cateagorySelected = catogeryArray![index.row]
        }
    }
}


