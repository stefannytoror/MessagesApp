//
//  StringExtension.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 31/05/22.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
}
