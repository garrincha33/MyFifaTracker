//
//  CreatePlayerController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 16/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class CreatePlayerController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightRedBackGround
        navigationItem.title = "Add Player"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        _ = setupLightRedBackGroundView(height: 150)
    }
    
    @objc fileprivate func handleCancelButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
