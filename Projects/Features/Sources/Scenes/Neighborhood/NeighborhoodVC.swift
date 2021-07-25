//
//  NeighborhoodVC.swift
//  Features
//
//  Created by 홍경표 on 2021/07/21.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa

final class NeighborhoodVC: UIViewController, View {
    
    private enum Images {
        static let searchImage: UIImage? = .init(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
        static let bellImage: UIImage? = .init(systemName: "bell")?.withRenderingMode(.alwaysOriginal)
    }
    
    var disposeBag: DisposeBag = .init()
    
    private lazy var tableView: UITableView = .init().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.separatorStyle = .none
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        $0.dataSource = self
        $0.delegate = self
        $0.estimatedRowHeight = 100
        $0.rowHeight = UITableView.automaticDimension
        $0.refreshControl = refreshControl
    }
    private let locationButton = UIBarButtonItem().then {
        $0.title = "마곡동"
        $0.tintColor = .label
        let attributes: [NSAttributedString.Key : Any]? = [
            .font: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold),
        ]
        $0.setTitleTextAttributes(attributes, for: .highlighted)
        $0.setTitleTextAttributes(attributes, for: .normal)
    }
    private let searchButton = UIBarButtonItem(image: Images.searchImage, style: .plain, target: nil, action: nil)
    private let bellButton = UIBarButtonItem(image: Images.bellImage, style: .plain, target: nil, action: nil)
    private let refreshControl: UIRefreshControl = .init()
    
    init(reactor: NeighborhoodReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    required init?(coder: NSCoder) {
        fatalError("All UIs are code based, not nib.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem()
        
        navigationItem.setRightBarButtonItems([bellButton, searchButton], animated: false)
        navigationItem.setLeftBarButton(locationButton, animated: false)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func bind(reactor: NeighborhoodReactor) {
        refreshControl.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.posts }
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .subscribe(onNext: { [weak self] (posts, newIndices) in
                if let newIndices = newIndices {
                    self?.tableView.insertRows(at: newIndices, with: .none)
                } else {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        reactor.errorSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.popUpErrorAlert(with: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func popUpErrorAlert(with error: Error) {
        let alert = UIAlertController(title: "\(error)", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - TableView DataSource

extension NeighborhoodVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.posts.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell,
              let post = reactor?.currentState.posts.data[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(post: post)
        return cell
    }
    
}

// MARK: - TableView Delegate

extension NeighborhoodVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = reactor?.currentState.posts.data.count ?? 0
        if (indexPath.row == (count - 1)) {
            reactor?.action.onNext(.fetch)
        }
    }
    
}
