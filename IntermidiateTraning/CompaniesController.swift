//
//  ViewController.swift
//  IntermidiateTraning
//
//  Created by tomo on 2019/12/19.
//  Copyright © 2019 tomo. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCampanyControllerDelegate {
    
    func didAddCompany(company: Company) {
        //1 modify your array
        companies.append(company)
        //2 insert a new index path into tableview
        let newIndexPath = IndexPath(row: companies.count - 1 , section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    private var companies = [Company]() // empty array
    
    func fetchCompanies() {
        // atempt my coredata fetch somehow...
        // initialize coredata stack
        // initialization of our coredata stack
        let persistentContainer = NSPersistentContainer(name: "intermidiateTrainingModels")
        persistentContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed:  \(err)")
            }
        }
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
             let companies = try context.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
            }
        } catch let fetchErr {
            print("Failed to fetch companeies: ", fetchErr)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddConpany))
        
        tableView.backgroundColor = .darkBlue
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.title = "Conpanies"
        
        
    }
    
    @objc func handleAddConpany() {
        print("add company...")
        
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
}

