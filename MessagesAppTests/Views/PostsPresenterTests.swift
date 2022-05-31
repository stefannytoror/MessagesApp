//
//  PostsPresenterTests.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import XCTest
@testable import MessagesApp

class PostsPresenterTests: XCTestCase {
    var presenter: PostsPresenter!
    var facade: PostsFacade!
    var client: HTTPClientMock!
    var storageManager: StorageManagerMock!
    var favoritesManager: FavoritesPostsManagerMock!
    private var view: PostsViewMock!

    override func setUpWithError() throws {
        client = HTTPClientMock()
        facade = PostsFacade(client: client)
        storageManager = StorageManagerMock()
        favoritesManager = FavoritesPostsManagerMock()
        view = PostsViewMock()
        presenter = PostsPresenter(facade: facade,
                                   storageManager: storageManager,
                                   favoritesManager: favoritesManager)
        presenter.view = view
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        client = nil
        facade = nil
        storageManager = nil
        favoritesManager = nil
        view = nil
        presenter = nil
    }

    func testDidLoad() throws {
        presenter.didLoad()
        XCTAssertTrue(view.configureSegmentedControlCalled)
        XCTAssertTrue(view.configureNavigationBarCalled)
        XCTAssertTrue(storageManager.objectsCalled)
    }

    func testReloadPosts() throws {
        presenter.reloadPosts()
        XCTAssertTrue(storageManager.objectsCalled)
    }

    func testSegmentedControlToFavorites() throws {
        presenter.segmentedControlTap(index: 1)
        XCTAssertTrue(favoritesManager.getFavoritesCalled)
        XCTAssertTrue(view.configurePostsListCalled)
    }

    func testDeleteAll() throws {
        presenter.deleteAllTapped()
        XCTAssertTrue(favoritesManager.removeAllCalled)
        XCTAssertTrue(storageManager.deleteAllCalled)
        XCTAssertTrue(view.configurePostsListCalled)
    }
}

private class PostsViewMock: PostsView {
    var configurePostsListCalled = false
    var configureSegmentedControlCalled = false
    var configureNavigationBarCalled = false
    var showAlertCalled = false

    func configurePostsList(posts: [PostViewModel]) {
        configurePostsListCalled = true
    }

    func configureSegmentedControl(model: SegmentedControlViewModel) {
        configureSegmentedControlCalled = true
    }

    func configureNavigationBar(model: NavigationBarModel) {
        configureNavigationBarCalled = true
    }

    func showAlert(model: AlertModel) {
        showAlertCalled = true
    }
}
