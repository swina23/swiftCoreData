//
//  EmployeesController.swift
//  IntermidiateTraning
//
//  Created by tomo on 2020/01/10.
//  Copyright © 2020 tomo. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
    }
    
    
    var company: Company?
    
    var employees = [Employee]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        self.employees = companyEmployees
//        print("Tring to fetch employees.")
//
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//        do {
//         let employees =  try context.fetch(request)
//            self.employees = employees
////            employees.forEach{print("Employee name:", $0.name ?? "")}
//        } catch let err {
//            print("Fail to fetch employees", err)
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        
        if let taxId = employee.employeeInformation?.taxId {
            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
        }
        
        
        
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        
        
        
        return cell
    }
    
    let cellId = "celllllllllllllId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        tableView.backgroundColor = .darkBlue
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    @objc private func handleAdd()  {
        print("trying to add employee")
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = self.company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
}
