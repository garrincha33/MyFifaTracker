//
//  CoreDataManager.swift
//  MyFifaTracker
//
//  Created by Richard Price on 02/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FifaTracker")
        container.loadPersistentStores(completionHandler: { (StoreManager, err) in
            if let err = err {
                print("unable to load persistant store", err)
            }
        })
        return container
    }()
    
    
    func resetCompanies(completion: () -> ()) {
        let context = persistantContainer.viewContext
        let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: Teams.fetchRequest())
        do {
            try context.execute(deleteBatchRequest)
            completion()
        } catch let err {
            print("unable to delete batch of companies \(err)")
        }
        
    }
    
    func fetchTeams() -> [Teams] {
        let context = persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Teams>(entityName: "Teams")
        
        do {
            let myTeams = try context.fetch(fetchRequest)
            return myTeams
        } catch let err {
            print("unable to fetch teams \(err)")
            return []
        }
    }
    
    func savePlayer(name: String, team: Teams, position: String) -> (Players?, Error?) {
        let context = persistantContainer.viewContext
        
        //create player
        let player = NSEntityDescription.insertNewObject(forEntityName: "Players", into: context) as! Players
        player.setValue(name, forKey: "name")
        player.team = team

        let playerPosition = NSEntityDescription.insertNewObject(forEntityName: "PlayerPositions", into: context) as! PlayerPositions
        playerPosition.position = position
        
        
        //IMPORTANT nothing will render without this
        player.playersPositions = playerPosition
  
        do {
            try context.save()
            return (player, nil)
        } catch let err {
            print("unable to save player to coredata \(err)")
            return (nil, err)
        }
    }
}



