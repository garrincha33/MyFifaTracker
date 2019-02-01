//
//  TeamsController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 31/01/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class TeamsController: UITableViewController {
    
    let cellId = "cellId"
    
    let teams = [
        Teams(teamName: "testing1", teamCreated: Date()),
        Teams(teamName: "testing2", teamCreated: Date()),
        Teams(teamName: "testing3", teamCreated: Date()),
        Teams(teamName: "testing4", teamCreated: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarStyle()
        
        tableView.backgroundColor = .lightRedBackGround
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Teams"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddTeam))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = teams[indexPath.row].teamName
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .cellRed
        return cell
        
    }
    
    @objc fileprivate func handleAddTeam() {
        print("test add team")
        
        let createTeamController = CreateTeamController()
        let navController = CustomNavigationController(rootViewController: createTeamController)
        present(navController, animated: true, completion: nil)
     
        
        
    }
    
}

