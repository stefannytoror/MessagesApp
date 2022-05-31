//
//  PostsFacadeTests.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import XCTest
@testable import MessagesApp

class PostsFacadeTests: XCTestCase {
    var facade: PostsFacade!
    var client: HTTPClientMock!

    override func setUpWithError() throws {
        super.setUp()
        client = HTTPClientMock()
        facade = PostsFacade(client: client)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        client = nil
        facade = nil
    }

    func testGetPostsSuccess() throws {
        let posts: [PostModel] = []
        client.response = posts

        let expectation = XCTestExpectation(description: "posts expectation")
        facade.getPosts { response in
            switch response {
            case .success(let posts):
                XCTAssertNotNil(posts)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetPostsFail() throws {
        client.isSuccessful = false

        let expectation = XCTestExpectation(description: "posts expectation")
        facade.getPosts { response in
            switch response {
            case .success(_):
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
