//
//  PostsPresenter.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import UIKit

protocol PostsPresenterProtocol {
    var view: PostsView? { get set }
    func didLoad()
    func segmentedControlTap(index: Int)
    func reloadPosts()
    func deleteAllTapped()
}

enum PostsSections: Int, CaseIterable {
    case all
    case favorites

    var text: String {
        switch self {
        case .all:
            return "All"
        case .favorites:
            return "Favorites"
        }
    }
}

class PostsPresenter {
    weak var view: PostsView?
    private var facade: PostsFacadeProtocol
    private var favoritesManager: FavoritesManagerProtocol
    private var storageManager: StorageManagerProtocol

    init(facade: PostsFacadeProtocol =  PostsFacade(),
         storageManager: StorageManagerProtocol = StorageManager(),
         favoritesManager: FavoritesManagerProtocol = FavoritesPostsManager.instance) {
        self.facade = facade
        self.favoritesManager = favoritesManager
        self.storageManager = storageManager
    }
}

extension PostsPresenter: PostsPresenterProtocol {
    func didLoad() {
        createSegmentedControlModel()
        createNavigationBarModel()
        checkCache()
    }

    func reloadPosts() {
        checkCache()
    }

    func deleteAllTapped() {
        self.view?.configurePostsList(posts: [])
        favoritesManager.removeAll()
        storageManager.deleteAll()
    }

    func segmentedControlTap(index: Int) {
        let section = PostsSections.allCases[index]
        switch section {
        case .favorites:
            self.view?.configurePostsList(posts: favoritesManager.getFavorites())
        case .all:
            checkCache()
        }
    }
}

private extension PostsPresenter {

    func checkCache() {
        let objects = storageManager.objects()
        
        if objects.isEmpty {
            getPosts()
        } else {
            self.createViewModel(from: objects)
        }
    }

    func getPosts() {
        facade.getPosts { [weak self] response in
            switch response {
            case .success(let posts):
                self?.savePosts(posts)
                self?.createViewModel(from: posts)
            case .failure(let error):
                print(error)
                self?.configureError()
            }
        }
    }

    func savePosts(_ posts: [PostModel]) {
        posts.forEach { storageManager.insert($0) }
    }

    func createSegmentedControlModel() {
        let model = SegmentedControlViewModel(segments: PostsSections.allCases.map { $0.text },
                                              tintColor: .primary)
        view?.configureSegmentedControl(model: model)
    }

    func createNavigationBarModel() {
        let model = NavigationBarModel(title: "POSTS_TITLE".localized(),
                                       rightButtonImage: UIImage.init(systemName: ImageName.reloadIcon))
        view?.configureNavigationBar(model: model)
    }

    func createViewModel(from posts: [PostModel]) {
        let postsViewModel = posts.map { PostViewModel(postId: $0.id,
                                                       userId: $0.userId,
                                                       image: favoritesManager.isFavorite(id: $0.id) ? UIImage.init(systemName: ImageName.starFill) ?? .init() : .init(),
                                                       title: $0.title,
                                                       body: $0.body)}
        DispatchQueue.main.async { [weak self] in
            self?.view?.configurePostsList(posts: postsViewModel)
        }
    }

    func configureError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlert(model: self.createAlertModel())
        }
    }

    func createAlertModel() -> AlertModel {
        .init(title: "SERVICE_GENERAL_ERROR_TITLE".localized(),
              message: "SERVICE_GENERAL_ERROR_MESSAGE".localized(),
              actions: [.init(title: "OK".localized(),
                              style: .default)])
    }
}
