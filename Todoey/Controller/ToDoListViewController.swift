//
//  ViewController.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 20/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "todo1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "todo2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "todo3"
        itemArray.append(newItem3)

        
        if let items = userDefault.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.userDefault.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (text) in
            text.placeholder = "Create new category"
            textField = text
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}

