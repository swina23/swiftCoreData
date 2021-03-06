//
//  CoreDataManager.swift
//  IntermidiateTraning
//
//  Created by tomo on 2019/12/21.
//  Copyright © 2019 tomo. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()  // will live forever as long as your appliction still alive, it's properties will to.
    
    let persistentContainer: NSPersistentContainer = {
        
        // initialize coredata stack
        // initialization of our coredata stack
        let container = NSPersistentContainer(name: "intermidiateTrainingModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed:  \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            return companies
            
        } catch let fetchErr {
            print("Failed to fetch companeies: ", fetchErr)
            return []
        }
    }
    
    func createEmployee(employeeName: String, company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        // create employee
         let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        
        employee.company = company
        
        // lets check company is setup correctly
//        let company = Company(context: context)
//        company.employees
//        employee.company
        
    
        employee.setValue(employeeName, forKey: "name")
        
        // create employee information
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation

//      employeeInformation.setValue("456", forKey: "taxId")
        employeeInformation.taxId = "456"
        

        
        employee.employeeInformation = employeeInformation
        
        do {
            try context.save()
            // save succeed
            return (employee, nil)
        } catch let err {
            print("Fail to create Employee...", err)
            return (nil, err)
        }
        
    }
}
