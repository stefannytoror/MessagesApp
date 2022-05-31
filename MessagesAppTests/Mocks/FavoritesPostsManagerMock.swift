//
//  FavoritesPostsManagerMock.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import Foundation
@testable import MessagesApp

class FavoritesPostsManagerMock: FavoritesManagerProtocol {
    var addFavoritesCalled = false
    var getFavoritesCalled = false
    var removeFavoriteCalled = false
    var removeAllCalled = false
    var isFavoriteCalled = false
    var isFavorite: Bool = false

    func addFavorites(post: PostViewModel) {
        addFavoritesCalled = true
    }

    func getFavorites() -> [PostViewModel] {
        getFavoritesCalled = true
        return []
    }

    func removeFavorite(id: Int) {
        removeFavoriteCalled = true
    }

    func removeAll() {
        removeAllCalled = true
    }

    func isFavorite(id: Int) -> Bool {
        isFavoriteCalled = true
        return isFavorite
    }
}
