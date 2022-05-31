//
//  CommentsRequest.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 30/05/22.
//

import Foundation
import Alamofire

struct CommentsRequest: HTTPRequest {
    typealias Response = [CommentModel]
    var endpoint: Endpoint
    var method: HTTPMethod = .get

    init(postId: String) {
        endpoint = .comments(postId)
    }
}
