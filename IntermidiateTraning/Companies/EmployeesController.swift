//
//  EmployeesController.swift
//  IntermidiateTraning
//
//  Created by tomo on 2020/01/10.
//  Copyright © 2020 tomo. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBlue
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    @objc private func handleAdd()  {
        print("trying to add employee")
        let createEmployeeController = CreateEmployeeController()
        let navController = UINavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
}
