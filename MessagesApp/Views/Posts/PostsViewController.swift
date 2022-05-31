//
//  PostsViewController.swift
//  MessagesApp
//
//  Created by Stefanny Toro Ramirez on 27/05/22.
//

import UIKit

protocol PostsView: AnyObject {
    func configurePostsList(posts: [PostViewModel])
    func configureSegmentedControl(model: SegmentedControlViewModel)
    func configureNavigationBar(model: NavigationBarModel)
    func showAlert(model: AlertModel)
}

class PostsViewController: UIViewController {

    @IBOutlet private weak var selectorView: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    private var posts: [PostViewModel] = []
    var presenter: PostsPresenterProtocol = PostsPresenter()

    private struct Constants {
        static let defaultSelectorIndex = 0
        static let rowHeight: CGFloat = 80
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        setupTableView()
        presenter.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.segmentedControlTap(index: selectorView.selectedSegmentIndex)
    }

    @IBAction private func onSegmentedControlChange(_ sender: Any) {
        presenter.segmentedControlTap(index: selectorView.selectedSegmentIndex)
    }

    @IBAction private func deleteAllTapped(_ sender: Any) {
        presenter.deleteAllTapped()
    }

    @objc private func reloadPosts() {
        selectorView.selectedSegmentIndex = Constants.defaultSelectorIndex
        presenter.reloadPosts()
    }
}

private extension PostsViewController {

    func setupTableView() {
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier:  String(describing: PostTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }

    func configureRightButton(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                                 style: .plain,
                                                                 target: self,action: #selector(reloadPosts))
    }
}

extension PostsViewController: PostsView {

    func configurePostsList(posts: [PostViewModel]) {
        self.posts = posts
        tableView.reloadData()
    }

    func configureSegmentedControl(model: SegmentedControlViewModel) {
        selectorView.configure(model: model)
    }

    func configureNavigationBar(model: NavigationBarModel) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
        self.navigationItem.title = model.title
        configureRightButton(image: model.rightButtonImage)
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

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self),
                                                       for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(viewModel: posts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailViewController = PostDetailViewController(post: post)
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension PostsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}
