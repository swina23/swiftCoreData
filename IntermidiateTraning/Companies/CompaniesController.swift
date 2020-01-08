//
//  ViewController.swift
//  IntermidiateTraning
//
//  Created by tomo on 2019/12/19.
//  Copyright © 2019 tomo. All rights reserved.
// git test

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCampanyControllerDelegate {
    
    private var companies = [Company]() // empty array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddConpany))
        
        fetchCompanies()
        
        tableView.backgroundColor = .darkBlue
//                tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.title = "Conpanies"
    }
    
    @objc private func handleReset() {
        print("Attenpt to delete all coredata objects")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //        companies.forEach { (company) in
        //            context.delete(company)
        //        }
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            // upon delation from core data succeeded
            var indexPathsToRemove = [IndexPath]()
            
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            //            companies.forEach { (company) in
            //                companies.lastIndex(of: <#T##Company#>)
            // but this loop does'nt provide us with the row number.
            
            //            }
            
            
            //            companies.removeAll()
            //            tableView.reloadData()
        } catch let delerror {
            print("Fail to delete coredata objects", delerror)
        }
    }
    
    func fetchCompanies() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
            }
            
            self.companies = companies
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch companeies: ", fetchErr)
        }
    }
    
    @objc func handleAddConpany() {
        print("add company...")
        
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    func didAddCompany(company: Company) {
        //1 modify your array
        companies.append(company)
        //2 insert a new index path into tableview
        let newIndexPath = IndexPath(row: companies.count - 1 , section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        // update my table somehow
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }

    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing company in separate function")
        let editCompanyController = CreateCompanyController()
        editCompanyController.delegate = self
        // company is not nil here
        editCompanyController.company = companies[indexPath.row]
        
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - tableview delegate methods
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let company = self.companies[indexPath.row]
            print("Attempting to delete company: ", company.name ?? "")
            
            // 1. remove company from our tableview
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // 2. delete company from coredata
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch let saveError {
                print("Failed to dalete company", saveError)
            }
        }
        deleteAction.backgroundColor = .lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        editAction.backgroundColor = .darkBlue
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        
        let company = companies[indexPath.row]
        cell.company = company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
}

