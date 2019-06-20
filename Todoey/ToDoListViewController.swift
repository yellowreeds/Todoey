//
//  ViewController.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 20/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [""]
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = userDefault.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            print("\(itemArray[indexPath.row]) is deselected")
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print("\(itemArray[indexPath.row]) is selected")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            
            self.userDefault.set(self.itemArray, forKey: "TodoListArray" )
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

