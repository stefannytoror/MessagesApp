//
//  UserInformationModel.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import Foundation

struct UserInformationModel: Codable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var website: String

    init() {
        id = 0
        name = ""
        email = ""
        phone = ""
        website = ""
    }
}
