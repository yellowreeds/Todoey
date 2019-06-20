//
//  ViewController.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 20/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["things1", "things2", "things3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    //MARK - TableView Delegate Method
    
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
    
    


}
