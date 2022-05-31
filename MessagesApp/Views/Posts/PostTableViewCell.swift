//
//  PostTableViewCell.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var chevron: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PostTableViewCell {
    func configure(viewModel: PostViewModel) {
        favoriteImageView.image = viewModel.image
        titleLabel.text =  viewModel.title
        chevron.image = viewModel.chevron
    }
}

struct PostViewModel {
    var postId: Int
    var userId: Int
    var image: UIImage
    var chevron: UIImage? = UIImage(named: ImageName.chevronRight)
    var title: String
    var body: String
}
