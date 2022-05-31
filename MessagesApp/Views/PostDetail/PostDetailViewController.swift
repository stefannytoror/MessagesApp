//
//  PostDetailViewController.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 29/05/22.
//
import UIKit

protocol PostDetailView: AnyObject {
    func setupInformation(_ userInformation: UserInformationModel)
    func setupComments(_ comments: [CommentModel])
    func configureRightButton(image: UIImage?)
    func configureNavigationBar(model: NavigationBarModel)
    func showAlert(model: AlertModel)
}

class PostDetailViewController: UIViewController {

    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    @IBOutlet private weak var userPhoneLabel: UILabel!
    @IBOutlet private weak var userWebsiteLabel: UILabel!
    @IBOutlet private weak var commentsStackView: UIStackView!

    var presenter: PostDetailPresenterProtocol = PostDetailPresenter()
    private var post: PostViewModel

    init(post: PostViewModel) {
        self.post = post
        presenter.postId = post.postId
        let nibName = String(describing: type(of: self))
        super.init(nibName: nibName, bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.configureView(userId: post.userId, postId: post.postId)
    }

    @objc private func favoritesTapped() {
        presenter.onFavoritesTap(post: post)
    }
}

extension PostDetailViewController: PostDetailView {

    func setupInformation(_ userInformation: UserInformationModel) {
        bodyLabel.text = post.body
        userNameLabel.text = userInformation.name
        userEmailLabel.text = userInformation.email
        userPhoneLabel.text = userInformation.phone
        userWebsiteLabel.text = userInformation.website
    }

    func setupComments(_ comments: [CommentModel]) {
        let views: [CommentView] = comments.map { comment in
            let view = CommentView()
            view.configure(model: comment)
            return view
        }

        views.forEach { view in
            commentsStackView.addArrangedSubview(view)
        }
    }

    func configureRightButton(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                                 style: .plain,
                                                                 target: self,action: #selector(favoritesTapped))
    }

    func configureNavigationBar(model: NavigationBarModel) {
        navigationItem.title = model.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: model.rightButtonImage,
                                                                 style: .plain,
                                                                 target: self,action: #selector(favoritesTapped))
    }

    func showAlert(model: AlertModel) {
        let alert = UIAlertController(title: model.title,
                                      message: model.message,
                                      preferredStyle: .alert)
        for action in model.actions {
            alert.addAction(action)
        }

        self.present(alert, animated: true, completion: model.completion)
    }
}
