//
//  UserInformationRequest.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 30/05/22.
//

import Foundation
import Alamofire

struct UserInformationRequest: HTTPRequest {
    typealias Response = UserInformationModel
    var endpoint: Endpoint
    var method: HTTPMethod = .get

    init(userId: String) {
        endpoint = .userInformation(userId)
    }
}
