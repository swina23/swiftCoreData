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
}
