//
//  CoreDataHelper.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 13.10.2022.
//

import Foundation
import CoreData

public class CoreDataHelper: NSObject {
    
    static let shared = CoreDataHelper()
    
    lazy var context = CoreDataHelper.shared.persistentContainer.viewContext
    static let kItem = "Search"
    static let kFilename = "SearcCache"
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataHelper.kFilename)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Adding More Helpers
    @discardableResult
    func addObject<T: NSManagedObject>(entity: T) -> T {
        
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return entity
    }
    
    func getDatas<T: NSManagedObject>(entity: T.Type) -> [T]? {
        let entityName = String(describing: entity)
        let request = NSFetchRequest<T>(entityName: entityName)
        let nameSort = NSSortDescriptor(key:"timeStamp", ascending: false)
        request.sortDescriptors = [nameSort]
        do {
            let result = try context.fetch(request)
            return result
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func saveDatabase(completion: (_ result: Bool) -> Void) {
        do {
            try context.save()
            
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
        
    }
    
    func removeLastSearch(title: String) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = context.persistentStoreCoordinator
        // Calculate the limit date for a record to be valid by using the days parameter of your method:
        // Create a predicate that match this date:
        let predicate = NSPredicate(format: "texts = %@", title)
        // Initialize the NSFetchRequest:
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchLocal")
        // Add the predicate to it:
        fetchRequest.predicate = predicate
        // Initialize your NSBatchDeleteRequest using your fetch request:
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        // Perform the delete operation asynchronously:
        privateContext.perform {
            do {
                // Try executing the batch request:
                try privateContext.execute(batchDeleteRequest)
                if privateContext.hasChanges {
                    // Reflect the changes if anything changed:
                    try privateContext.save()
                }
            }
            catch let error {
                // Handle the error here
                print(error)
            }
        }
    }
    
    func deleteManagedObject(managedObject: NSManagedObject, completion:(_ result: Bool) -> Void) {
        
        context.delete(managedObject)
        
        do {
            try context.save()
            
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    func removeAll<T: NSManagedObject>(entity: T.Type, completion: ((_ result: Bool) -> Void)? = nil) {
        let entityName = String(describing: entity)
        let request = NSFetchRequest<T>(entityName: entityName)
        
        do {
            let results = try context.fetch(request)
            for managedObject in results {
                context.delete(managedObject)
            }
            try context.save()
            completion?(true)
        } catch let error as NSError {
            print("Detele all \(error) \(error.userInfo)")
            completion?(false)
        }
    }
}
