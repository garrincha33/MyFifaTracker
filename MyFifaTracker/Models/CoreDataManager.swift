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
}



