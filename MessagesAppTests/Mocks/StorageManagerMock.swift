//
//  StorageManagerMock.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import Foundation
import Alamofire
@testable import MessagesApp

class StorageManagerMock: StorageManagerProtocol {
    var insertCalled: Bool = false
    var objectsCalled: Bool = false
    var deleteAllCalled: Bool = false

    func insert(_ object: PostModel) {
        insertCalled = true
    }

    func objects() -> [PostModel] {
        objectsCalled = true
        return []
    }

    func deleteAll() {
        deleteAllCalled = true
    }
}
