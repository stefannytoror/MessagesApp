//
//  HTTPClientMock.swift
//  MessagesAppTests
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import Foundation
import Alamofire
@testable import MessagesApp

class HTTPClientMock: HTTPClientProtocol {
    var isSuccessful: Bool = true
    var response: Codable?

    func request<Request: HTTPRequest>(request: Request,
                                       completion: @escaping (Result<Request.Response, AFError>) -> Void) {
        completion(isSuccessful ? susscessfulResponse(request: request, response: response) : failureResponse(request: request))
    }

    func susscessfulResponse<Request: HTTPRequest>(request: Request, response: Codable?) -> Result<Request.Response, AFError> {
        guard let response = response as? Request.Response else {
            return .failure(AFError.explicitlyCancelled)
        }

        return .success(response)
    }

    func failureResponse<Request: HTTPRequest>(request: Request) -> Result<Request.Response, AFError> {
        return .failure(.explicitlyCancelled)

    }
}
