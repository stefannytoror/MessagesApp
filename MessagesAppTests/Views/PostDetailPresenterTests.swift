//
//  PostDetailPresenterTests.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import XCTest
@testable import MessagesApp

class PostDetailPresenterTests: XCTestCase {
    var presenter: PostDetailPresenter!
    var facade: PostDetailFacade!
    var client: HTTPClientMock!
    var favoritesManager: FavoritesPostsManagerMock!
    private var view: PostsDetailViewMock!

    override func setUpWithError() throws {
        super.setUp()
        client = HTTPClientMock()
        facade = PostDetailFacade(client: client)
        favoritesManager = FavoritesPostsManagerMock()
        view = PostsDetailViewMock()
        presenter = PostDetailPresenter(facade: facade,
                                        favoritesManager: favoritesManager)
        presenter.view = view
        presenter.postId = 0
    }

    override func tearDownWithError() throws {
        super.tearDown()
        client = nil
        facade = nil
        favoritesManager = nil
        view = nil
        presenter = nil
    }

    func testConfigureView() throws {
        presenter.configureView(userId: 0, postId: 0)
        XCTAssertTrue(view.configureNavigationBarCalled)
    }

    func testAddToFavorites() throws {
        presenter.onFavoritesTap(post: .init(postId: 0,
                                             userId: 0,
                                             image: UIImage(),
                                             title: "",
                                             body: ""))
        XCTAssertTrue(view.configureRightButtonCalled)
        XCTAssertTrue(favoritesManager.addFavoritesCalled)
    }

    func testRemoveToFavorites() throws {
        favoritesManager.isFavorite = true
        presenter.onFavoritesTap(post: .init(postId: 0,
                                             userId: 0,
                                             image: UIImage(),
                                             title: "",
                                             body: ""))
        XCTAssertTrue(view.configureRightButtonCalled)
        XCTAssertTrue(favoritesManager.removeFavoriteCalled)
    }
}

private class PostsDetailViewMock: PostDetailView {
    var setupInformationCalled = false
    var setupCommentsCalled = false
    var configureRightButtonCalled = false
    var configureNavigationBarCalled = false
    var showAlertCalled = false

    func setupInformation(_ userInformation: UserInformationModel) {
        setupInformationCalled = true
    }

    func setupComments(_ comments: [CommentModel]) {
        setupCommentsCalled = true
    }

    func configureRightButton(image: UIImage?) {
        configureRightButtonCalled = true
    }

    func configureNavigationBar(model: NavigationBarModel) {
        configureNavigationBarCalled = true
    }

    func showAlert(model: AlertModel) {
        showAlertCalled = true
    }
}
