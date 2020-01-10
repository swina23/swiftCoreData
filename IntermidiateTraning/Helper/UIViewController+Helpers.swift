//
//  UIViewController+Helpers.swift
//  IntermidiateTraning
//
//  Created by tomo on 2020/01/10.
//  Copyright © 2020 tomo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // my extention/helper methods
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightBlueBackgroundView
    }
}
