//
//  DataBaseWrapper.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit
import CoreData

class DataBaseWrapper: NSObject {
    
    static let sharedInstance = DataBaseWrapper()
    
    private override init() {
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func savePersonDetails(personDetail: PersonDetail) ->Bool {
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let personDetailManagedObject = Person(entity: entity,
                                               insertInto: managedContext)
        personDetailManagedObject.firstName = personDetail.firstName
        personDetailManagedObject.lastName = personDetail.lastName
        personDetailManagedObject.email = personDetail.emailId
        personDetailManagedObject.profileUrl = personDetail.imageUrl
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("not able to save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func getAllPersonDetails() -> [Person]? {
        var movies: [Person] = []
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do {
            movies = try managedContext.fetch(fetchRequest)
            return movies
        } catch let error as NSError {
            print("not able to fetch. \(error), \(error.userInfo)")
        }
        return movies
    }
}
