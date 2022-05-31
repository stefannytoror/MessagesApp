//
//  PostDetailFacadeTests.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import XCTest
@testable import MessagesApp

class PostDetailFacadeTests: XCTestCase {
    var facade: PostDetailFacade!
    var client: HTTPClientMock!

    override func setUpWithError() throws {
        super.setUp()
        client = HTTPClientMock()
        facade = PostDetailFacade(client: client)
    }

    override func tearDownWithError() throws {
        client = nil
        facade = nil
        super.tearDown()
    }

    func testGetCommentsSuccess() throws {
        let comments: [CommentModel] = []
        client.response = comments

        let expectation = XCTestExpectation(description: "comments expectation")
        facade.getComments(postId: 1) { response in
            switch response {
            case .success(let comments):
                XCTAssertNotNil(comments)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCommentsFail() throws {
        client.isSuccessful = false

        let expectation = XCTestExpectation(description: "comments expectation")
        facade.getComments(postId: 1) { response in
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

    func testGetUserInformationSuccess() throws {
        let userInformation: UserInformationModel = .init()
        client.response = userInformation

        let expectation = XCTestExpectation(description: "user Information expectation")
        facade.getUserInformation(userId: 1) { response in
            switch response {
            case .success(let userInformation):
                XCTAssertNotNil(userInformation)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUserInformationFail() throws {
        client.isSuccessful = false

        let expectation = XCTestExpectation(description: "user Information expectation")
        facade.getUserInformation(userId: 1) { response in
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
