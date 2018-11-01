//
//  CoreDataStack.swift
//  venturenotes
//
//  Created by David Doswell on 11/1/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
        
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Venture" as String)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext { return container.viewContext }
}
