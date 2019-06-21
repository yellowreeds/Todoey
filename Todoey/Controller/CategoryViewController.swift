//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 21/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CategoryCell")
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }

    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategories(_ request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching context, \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
    //MARK: - Add New Categories    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        
        var textCategoryField : UITextField = UITextField()
        
        let categoryAlert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let categoryAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textCategoryField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
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
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
}
