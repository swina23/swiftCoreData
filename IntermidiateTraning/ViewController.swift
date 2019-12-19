//
//  ViewController.swift
//  IntermidiateTraning
//
//  Created by tomo on 2019/12/19.
//  Copyright © 2019 tomo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleConpany))
        
        setNavigationStyleUp()
    }
    
    @objc func handleConpany() {
        print("add company...")
    }
    
    func setNavigationStyleUp () {
        navigationItem.title = "Conpanies"
        navigationController?.navigationBar.isTranslucent = false
        
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = lightRed
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }


}

