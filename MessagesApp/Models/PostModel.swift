//
//  PostModel.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 27/05/22.
//

import Foundation
import CoreData

struct PostModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String


    init(_ entity: PostEntity) {
        self.userId = Int(entity.userId)
        self.id = Int(entity.postId)
        self.title = entity.title ?? ""
        self.body = entity.body ?? ""
    }
}

extension PostModel {
    func getEntityName() -> String {
        return "PostEntity"
    }

    func transformToStorableEntity(_ managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        guard let storedEntity = NSEntityDescription.entity(forEntityName: String(describing: getEntityName()),
                                                            in: managedObjectContext) else {
                return nil
        }

        let postEntity = NSManagedObject(entity: storedEntity, insertInto: managedObjectContext)
        postEntity.setValue(id, forKeyPath: "postId")
        postEntity.setValue(userId, forKeyPath: "userId")
        postEntity.setValue(title, forKeyPath: "title")
        postEntity.setValue(body, forKeyPath: "body")

        return postEntity
    }
}
