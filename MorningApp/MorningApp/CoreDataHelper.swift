//
//  CoreDataHelper.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/1.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    static func newTask() -> Task {
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
        return task
    }
    
    static func saveTime() {
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(task: Task) {
        managedContext.delete(task)
        saveTime()
    }
    
    static func retrieveTime() -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
}
