//
//  PostDetailPresenter.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import Foundation
import UIKit

protocol PostDetailPresenterProtocol {
    var view: PostDetailView? { get set }
    var postId: Int { get set }
    func configureView(userId: Int, postId: Int)
    func onFavoritesTap(post: PostViewModel)
}

class PostDetailPresenter {
    weak var view: PostDetailView?
    var postId: Int = 0

    private var facade: PostDetailFacadeProtocol
    private var favoritesManager: FavoritesManagerProtocol

    init(facade: PostDetailFacadeProtocol = PostDetailFacade(),
         favoritesManager: FavoritesManagerProtocol = FavoritesPostsManager.instance) {
        self.facade = facade
        self.favoritesManager = favoritesManager
    }
}

extension PostDetailPresenter: PostDetailPresenterProtocol {

    func configureView(userId: Int, postId: Int) {
        createNavigationBarModel()
        facade.getUserInformation(userId: userId) { [weak self] response in
            switch response {
            case .success(let userInformation):
                self?.createPostDetailModel(userInformation: userInformation)
            case .failure(let error):
                print(error)
                self?.configureError()
            }
        }

        facade.getComments(postId: postId) { [weak self] response in
            switch response {
            case .success(let comments):
                self?.configureComments(comments: comments)
            case .failure(let error):
                // Handle error
                print(error)
                self?.configureError()
            }
        }
    }

    func onFavoritesTap(post: PostViewModel) {
        if favoritesManager.isFavorite(id: postId) {
            favoritesManager.removeFavorite(id: post.postId)
        } else {
            favoritesManager.addFavorites(post: post)
        }

        updateFavoriteIcon()
    }
}

private extension PostDetailPresenter {

    func createNavigationBarModel() {
        let model: NavigationBarModel = .init(title: "POST_TITLE".localized(), rightButtonImage: UIImage.init(systemName:  favoritesManager.isFavorite(id: postId) ? ImageName.starFill : ImageName.star))
        view?.configureNavigationBar(model: model)
    }

    func updateFavoriteIcon() {
        view?.configureRightButton(image: UIImage.init(systemName:  favoritesManager.isFavorite(id: postId) ? ImageName.starFill : ImageName.star))
    }


    func createPostDetailModel(userInformation: UserInformationModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setupInformation(userInformation)
        }
    }

    func configureComments(comments: [CommentModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setupComments(comments)
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
