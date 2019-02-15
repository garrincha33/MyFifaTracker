//
//  +TeamsController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 15/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

extension TeamsController: createTeamControllerDelegate {

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

}
