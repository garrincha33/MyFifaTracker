//
//  +TeamsControllerTableViews.swift
//  MyFifaTracker
//
//  Created by Richard Price on 15/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

extension TeamsController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TeamsCustomCell
        let team = teams[indexPath.row]
        cell.team = team
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
    
    
    
    
}
