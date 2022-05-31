//
//  PostsFacade.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import Foundation
import Alamofire

protocol PostsFacadeProtocol {
    func getPosts(completion: @escaping (Result<[PostModel], AFError>) -> Void)
}


class PostsFacade: PostsFacadeProtocol {
    var client: HTTPClientProtocol

    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
    }

    func getPosts(completion: @escaping (Result<[PostModel], AFError>) -> Void) {
        let postsRequest = PostsRequest()
        client.request(request: postsRequest) { response in
            completion(response)
        }
    }
}
