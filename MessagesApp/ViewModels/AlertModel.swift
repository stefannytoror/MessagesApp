//
//  AlertModel.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import UIKit

struct AlertModel {
    var title: String
    var message: String
    var actions: [UIAlertAction]
    var completion: (() ->Void)?
}
