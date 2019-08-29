//
//  ViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/27/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
class ToDoListController: UITableViewController  {
    let realm = try! Realm()
  
    var cateagorySelected : Cateagory? {
        didSet{
          load()
        }
    }
    var elements : Results<Item>?
    var item = Item()
 

    override func viewDidLoad() {
        // add DataPresitance
  
        super.viewDidLoad()
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

       load()
        // Do any additional setup after loading the view.
    }
    //add elements to cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
      if  let item = elements?[indexPath.row] {
            cell.textLabel?.text = item.itemName
            cell.accessoryType = item.itemIsChecked ? .checkmark : .none
            
      } else {
        cell.textLabel?.text = "no items"
        cell.accessoryType = .none
        
        }
      

        return cell
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements?.count ?? 1
    }

    //selected row method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let item = elements?[indexPath.row].itemIsChecked ?? false
        let cell =  tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = item ? .none : .checkmark
      
        if let currentItem = elements?[indexPath.row] {
            do{
            try  realm.write {
                currentItem.itemIsChecked =  !currentItem.itemIsChecked
                // delete realm.delete(item)
                }}catch{}
        }
     // elements[indexPath.row].itemIsChecked = !item

        tableView.deselectRow(at: indexPath, animated: true)
//saveItem()
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
         // let itennewb=Item()

         
            if let currecntCatagory = self.cateagorySelected {
                do {
                    try self.realm.write {
                        let item = Item()
                        item.itemName = textFeleld.text!
                        
                        
                        currecntCatagory.items.append(item)
                        
                    }}catch{}
            }
            
            self.tableView.reloadData()
            self.load()
            //
        }
        alert.addAction(action)
        present(alert,animated: true , completion: nil)
    }
    func saveItem(itemo : Item) {
       // let encoders = PropertyListEncoder()
    
    }
    //Mark: - load data from Coretable
    //what after = is default parameter
    func load(){
        
        elements = cateagorySelected?.items.sorted(byKeyPath: "itemName", ascending: true)
    
tableView.reloadData()
//
//
//    }
    //delete from table and array
//    func delete(){
//        context.delete(elements[2])
//        elements.remove(at: 2)
//    }
    //MARK: - Search bar extenstion
  
   
    }}

extension ToDoListController : UISearchBarDelegate {

   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            load()
        }
        else {
elements = elements?.filter("itemName CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "itemName", ascending: true)

        }}
//    }
    
}
