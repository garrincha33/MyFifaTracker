//
//  PlayersController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 16/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class PlayersController: UITableViewController {
    
    var team: Teams?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavControllerButtonsInNavBar(selector: #selector(handleAddPlayer))
        tableView.backgroundColor = .lightRedBackGround
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = team?.name
        
    }
    
    @objc fileprivate func handleAddPlayer() {
        let createPlayerController = CreatePlayerController()
        let navController = CustomNavigationController(rootViewController: createPlayerController)
        present(navController, animated: true, completion: nil)
    }

}
