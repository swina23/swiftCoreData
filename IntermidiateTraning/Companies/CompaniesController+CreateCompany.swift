//
//  CompaniesController+CreateCompany.swift
//  IntermidiateTraning
//
//  Created by tomo on 2020/01/10.
//  Copyright © 2020 tomo. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCampanyControllerDelegate {
    
    // specify your extension mothod here.
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
}
