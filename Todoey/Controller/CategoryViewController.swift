//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 21/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categoryResults: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryResults?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CategoryCell")
        
        cell.textLabel?.text = categoryResults?[indexPath.row].name ?? "No categories added yet"
        
        return cell
        
    }

    //MARK: - Data Manipulation Methods
    
    func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error write realm, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        categoryResults = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    
    
    
    //MARK: - Add New Categories    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        
        var textCategoryField : UITextField = UITextField()
        
        let categoryAlert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let categoryAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textCategoryField.text!
            
            self.saveCategories(category: newCategory)
        }
        
        categoryAlert.addTextField { (text) in
            text.placeholder = "Create new category"
            textCategoryField = text
        }
        
        categoryAlert.addAction(categoryAction)
        
        present(categoryAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryResults?[indexPath.row]
        }
    }
    
    
    
}
