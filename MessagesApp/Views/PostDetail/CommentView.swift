//
//  CommentView.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import UIKit

class CommentView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commmonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commmonInit()
    }

    func configure(model: CommentModel) {
        nameLabel.text = model.name
        bodyLabel.text = model.body
    }
}


private extension CommentView {
    
    func commmonInit() {
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: String(describing: CommentView.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds

        if let view = view {
            addSubview(view)
        }
    }
}
