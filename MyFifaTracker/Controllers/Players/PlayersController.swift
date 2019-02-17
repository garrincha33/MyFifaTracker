//
//  PlayersController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 16/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import CoreData

class PlayersController: UITableViewController, createPlayerControllerDelegate {
    func didAddPlayer(player: Players) {
        players.append(player)
        tableView.reloadData()
    }
    
    let cellId = "cellId"
    var team: Teams?
    var players = [Players]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupNavControllerButtonsInNavBar(selector: #selector(handleAddPlayer))
        tableView.backgroundColor = .lightRedBackGround
        tableView.separatorStyle = .none
        fetchPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = team?.name
        
    }
    
    fileprivate func fetchPlayers() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Players>(entityName: "Players")
        do {
            let players = try context.fetch(fetchRequest)
            self.players = players
        } catch let err {
            print("unable to fetch players", err)
        }
    }
    
    @objc fileprivate func handleAddPlayer() {
        let createPlayerController = CreatePlayerController()
        createPlayerController.delegate = self
        let navController = CustomNavigationController(rootViewController: createPlayerController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let player = players[indexPath.row]
        cell.textLabel?.text = player.name
        
        if let goal = player.playersstats?.goals {
            cell.textLabel?.text = "\(player.name ?? "")    \(goal)"
        }
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.backgroundColor = .cellRed
        return cell
        
    }
    
}
