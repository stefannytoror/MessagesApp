//
//  PostDetailFacade.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import Foundation
import Alamofire

protocol PostDetailFacadeProtocol {
    func getUserInformation(userId: Int, completion: @escaping (Result<UserInformationModel, AFError>) -> Void)
    func getComments(postId: Int, completion: @escaping (Result<[CommentModel], AFError>) -> Void)
}

class PostDetailFacade: PostDetailFacadeProtocol {
    var client: HTTPClientProtocol

    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
    }

    func getUserInformation(userId: Int, completion: @escaping (Result<UserInformationModel, AFError>) -> Void) {
        let userInfoRequest = UserInformationRequest(userId: String(userId))
        client.request(request: userInfoRequest) { response in
            completion(response)
        }
    }

    func getComments(postId: Int, completion: @escaping (Result<[CommentModel], AFError>) -> Void) {
        let commentRequest = CommentsRequest(postId: String(postId))
        client.request(request: commentRequest) { response in
            completion(response)
        }
    }
}
