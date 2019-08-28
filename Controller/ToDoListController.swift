//
//  ViewController.swift
//  Rembember
//
//  Created by ADMIN on 8/27/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import UIKit
import CoreData
class ToDoListController: UITableViewController  {
    var selectedCatogery : Catogery? {
        didSet {
            load()
        }
    }
  var elements = [Item]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let userDefault = UserDefaults.standard
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        // add DataPresitance
  
        super.viewDidLoad()
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

      //  load()
        // Do any additional setup after loading the view.
    }
    //add elements to cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row].itemName
        cell.accessoryType = elements[indexPath.row].itemIsChecked ? .checkmark : .none

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
      
        
      // elements[indexPath.row].itemIsChecked = !item
     elements[indexPath.row].setValue( !item, forKey: "itemIsChecked")

        tableView.deselectRow(at: indexPath, animated: true)
        saveItem()
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

          
            let item = Item(context : self.context)
            item.itemName=textFeleld.text!
            item.itemIsChecked=false
            item.parentCatogery = self.selectedCatogery
            self.elements.append(item)
self.saveItem()
            //
        }
        alert.addAction(action)
        present(alert,animated: true , completion: nil)
    }
    func saveItem() {
       // let encoders = PropertyListEncoder()
        do{
            try self.context.save()

         //   let data = try encoders.encode(self.elements)
          //  try data.write(to: self.filePath!)
        }catch{}
        self.tableView.reloadData()
    }
    //Mark: - load data from Coretable
    //what after = is default parameter
    func load(with request : NSFetchRequest<Item> = Item.fetchRequest() , predicate : NSPredicate? = nil){
        let predicable = NSPredicate(format: "parentCatogery.name MATCHES %@", selectedCatogery!.name!)
        if let additionallPredi = predicate {
           request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicable,predicate!])
     

        } else {
              request.predicate = predicable
        }
    
        do{
    elements = try self.context.fetch(request)
        }catch{
            
        }
        tableView.reloadData()

        
    }
    //delete from table and array
    func delete(){
        context.delete(elements[2])
        elements.remove(at: 2)
    }
    //MARK: - Search bar extenstion
  
   
}

extension ToDoListController : UISearchBarDelegate {

   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
                self.load(with : request )

                
            }
        }else{
              var  predicateable = NSPredicate(format: "itemName CONTAINS[cd] %@" , searchBar.text!)
            predicateable = NSPredicate(format: "itemName CONTAINS[cd] %@" , searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)]
            do{
                elements = try self.context.fetch(request)
            }catch{
                
            }
            load(with : request , predicate: predicateable)

            
        }
    }
    
}
