//
//  StorageManager.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 30/05/22.
//

import Foundation
import CoreData
import UIKit

protocol StorageManagerProtocol {
    func insert(_ object: PostModel)
    func objects() -> [PostModel]
    func deleteAll()
}

class StorageManager: StorageManagerProtocol {

    var managedObjectContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        return appDelegate.persistentContainer.viewContext
    }

    func insert(_ object: PostModel) {
        guard let managedObjectContext = managedObjectContext,
              let storableObject = transformToStorableEntity(object) else {
            return
        }

        managedObjectContext.insert(storableObject)
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not insert: \(PostModel.self) to \(PostEntity.self) -> Error: \(error)")
        }
    }

    func objects() -> [PostModel] {
        guard let managedObjectContext = managedObjectContext else {
            print("Fail")
            return []
        }

        var entities: [PostModel] = []

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: PostEntity.self))
        do {
            guard let objects = try managedObjectContext.fetch(fetchRequest) as? [PostEntity] else {
                return entities
            }

            entities = objects.map({ PostModel($0) })

        } catch {
            fatalError("Failed to fetch \(String(describing: PostModel.self)): \(error)")
        }
        return entities
    }

    func deleteAll() {
        guard let managedObjectContext = managedObjectContext else {
            return
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: PostEntity.self))
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            for object in results {

                guard let objectData = object as? NSManagedObject else {
                    continue
                }

                managedObjectContext.delete(objectData)
            }

            try managedObjectContext.save()
        } catch let error {
            assertionFailure("Delete all data in \(String(describing: PostEntity.self)) error : \(error)")
        }
    }

    private func transformToStorableEntity(_ entity: PostModel) -> NSManagedObject? {
        guard let managedContext = managedObjectContext,
              let storableEntity = entity.transformToStorableEntity(managedContext) as? PostEntity else {
            return nil
        }

        return storableEntity
    }
}
