//
//  PostsRequest.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 30/05/22.
//

import Foundation
import Alamofire

struct PostsRequest: HTTPRequest {
    typealias Response = [PostModel]
    var endpoint: Endpoint = .posts
    var method: HTTPMethod = .get
}
