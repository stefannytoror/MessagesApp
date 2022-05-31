//
//  SegmentedControlExtension.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 30/05/22.
//

import UIKit

struct SegmentedControlViewModel {
    var segments: [String]
    var tintColor: UIColor = .primary
}

extension UISegmentedControl {

    func configure(model: SegmentedControlViewModel) {
        for (index, segment) in model.segments.enumerated() {
            if index < numberOfSegments {
                setTitle(segment, forSegmentAt: index)
            } else {
                insertSegment(withTitle: segment, at: index, animated: false)
            }
        }

        selectedSegmentIndex = .zero
        selectedSegmentTintColor = model.tintColor
        layer.borderWidth = 1
        layer.borderColor = model.tintColor.cgColor
    }    
}
