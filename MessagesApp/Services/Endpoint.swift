//
//  Endpoint.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 27/05/22.
//

import Foundation

struct BaseHost {
    var url = "https://jsonplaceholder.typicode.com"
}

enum Endpoint {
    case posts
    case userInformation(String)
    case comments(String)

    var rawValue: String {
        switch self {
        case .posts:
            return "getPosts"
        case .userInformation:
            return "getUserInformation"
        case .comments:
            return "getComments"
        }
    }

    func getEndpoint() -> String? {
        guard let path = Bundle.main.path(forResource: "Endpoint", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let endpoint = dict[self.rawValue] as? String else {
                return nil
        }

        switch self {
        case .posts:
            return endpoint
        case .userInformation(let userId):
            return String(format: endpoint, arguments: [userId])
        case .comments(let postId):
            return String(format: endpoint, arguments: [postId])
        }
    }
}
