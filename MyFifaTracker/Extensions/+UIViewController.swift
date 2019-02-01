//
//  +UIViewController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 01/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupNavBarStyle() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .myRed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes  = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

