//
//  FavoritesPostsManager.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import Foundation

protocol FavoritesManagerProtocol {
    func addFavorites(post: PostViewModel)
    func getFavorites() -> [PostViewModel]
    func removeFavorite(id: Int)
    func removeAll()
    func isFavorite(id: Int) -> Bool
}


class FavoritesPostsManager: FavoritesManagerProtocol {
    static let instance = FavoritesPostsManager()

    private var favorites: [PostViewModel] = []

    func addFavorites(post: PostViewModel) {
        favorites.append(post)
    }

    func getFavorites() -> [PostViewModel] {
        return favorites
    }

    func removeFavorite(id: Int) {
        favorites.removeAll(where: {$0.postId == id })
    }

    func removeAll() {
        favorites = []
    }

    func isFavorite(id: Int) -> Bool {
        let post = favorites.first(where: {$0.postId == id})

        guard post != nil else {
            return false
        }

        return true
    }
}
