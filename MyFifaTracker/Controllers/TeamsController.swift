//
//  TeamsController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 31/01/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import CoreData

class TeamsController: UITableViewController, createTeamControllerDelegate {
    
    func editTeam(team: Teams) {
        let row = teams.index(of: team)
        let reloadPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadPath], with: .middle)
    }
    
    
    func addTeam(team: Teams) {
        teams.append(team)
        let newIndexPath = IndexPath(row: teams.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .middle)
    }
    
    let cellId = "cellId"
    var teams = [Teams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarStyle()
        
        tableView.backgroundColor = .lightRedBackGround
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Teams"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddTeam))
        
        fetchTeams()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = teams[indexPath.row].name
        
        let team = teams[indexPath.row]
        
        if let t = team.name, let created = team.created {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MM yyyy"
            let createdString = dateFormatter.string(from: created)
            
            let dateString = "\(t) - created :- \(createdString)"
            cell.textLabel?.text = dateString
        } else {
            cell.textLabel?.text = team.name
        }

        cell.textLabel?.textColor = .white
        cell.backgroundColor = .cellRed
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let team = self.teams[indexPath.row]
            print("attempting to delete team :-", team.name ?? "")
            self.teams.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistantContainer.viewContext
            context.delete(team)
            
            do {
                try context.save()
            } catch let err {
                print("error deleting from coreData", err)
            }
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        return [deleteAction, editAction]
    }
    
    fileprivate func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("test edit")
        let editComapanyController = CreateTeamController()
        editComapanyController.team = teams[indexPath.row]
        editComapanyController.delegate = self
        let navController = CustomNavigationController(rootViewController: editComapanyController)
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func fetchTeams() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Teams>(entityName: "Teams")
        do {
            let myTeams = try context.fetch(fetchRequest)
            myTeams.forEach { (team) in
                print(team.name ?? "")
            }
            self.teams = myTeams
            self.tableView.reloadData()
        } catch let err {
            print("unable to fetch teams", err)
        }
    }
    
    @objc fileprivate func handleAddTeam() {
        print("test add team")
        let createTeamController = CreateTeamController()
        let navController = CustomNavigationController(rootViewController: createTeamController)
        createTeamController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
}

