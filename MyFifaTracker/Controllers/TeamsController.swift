//
//  TeamsController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 31/01/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import CoreData

class TeamsController: UITableViewController {
    
    let cellId = "cellId"
    var teams = [Teams]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .lightRedBackGround
        tableView.separatorStyle = .none
        tableView.register(TeamsCustomCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Teams"
        setupNavControllerButtonsInNavBar(selector: #selector(handleAddTeam))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "reset1"), style: .plain, target: self, action: #selector(handleBatchDelete))
        fetchTeams()
        
        
    }
    
    fileprivate func fetchTeams() {
        self.teams = CoreDataManager.shared.fetchTeams()
    }
    
    @objc fileprivate func handleAddTeam() {
        print("test add team")
        let createTeamController = CreateTeamController()
        let navController = CustomNavigationController(rootViewController: createTeamController)
        createTeamController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleBatchDelete() {
        CoreDataManager.shared.resetCompanies {
            var indexPathToRemove = [IndexPath]()
            for(index, _) in teams.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathToRemove.append(indexPath)
            }
            teams.removeAll()
            tableView.deleteRows(at: indexPathToRemove, with: .left)
        }
    }
}

