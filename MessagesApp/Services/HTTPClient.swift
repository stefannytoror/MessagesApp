//
//  HTTPClient.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 27/05/22.
//

import Foundation
import Alamofire


protocol HTTPRequest {
    associatedtype Response: Codable

    var endpoint: Endpoint { get }
    var method: Alamofire.HTTPMethod { get }
}

protocol HTTPClientProtocol {
    func request<Request: HTTPRequest>(request: Request, completion: @escaping (Result<Request.Response, AFError>) -> Void)
}

class HTTPClient: HTTPClientProtocol {
    private var baseUrl: BaseHost

    init(baseUrl: BaseHost = .init()) {
        self.baseUrl = baseUrl
    }

    func request<Request: HTTPRequest>(request: Request, completion: @escaping (Result<Request.Response, AFError>) -> Void) {
        AF.request(baseUrl.url + (request.endpoint.getEndpoint() ?? ""),
                   method: request.method).responseDecodable(of: Request.Response.self) { response in
            completion(response.result)
        }
    }
}
