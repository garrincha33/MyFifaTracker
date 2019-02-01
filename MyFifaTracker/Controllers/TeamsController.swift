//
//  TeamsController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 31/01/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class TeamsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarStyle()
        
        tableView.backgroundColor = .lightRedBackGround
        tableView.separatorStyle = .none
        navigationItem.title = "Teams"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        cell.backgroundColor = .cellRed
        return cell
        
    }

}

