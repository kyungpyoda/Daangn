//
//  NeighborhoodVC.swift
//  Features
//
//  Created by 홍경표 on 2021/07/21.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

final class NeighborhoodVC: UIViewController {
    
    private enum Images {
        static let searchImage: UIImage? = .init(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
        static let bellImage: UIImage? = .init(systemName: "bell")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let tableView: UITableView = .init().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.separatorStyle = .none
    }
    
    private let locationButton = UIBarButtonItem().then {
        $0.title = "마곡동"
        $0.tintColor = .label
        let attributes: [NSAttributedString.Key : Any]? = [
            .font: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold),
        ]
        $0.setTitleTextAttributes(attributes, for: .selected)
        $0.setTitleTextAttributes(attributes, for: .normal)
    }
    private let searchButton = UIBarButtonItem(image: Images.searchImage, style: .plain, target: nil, action: nil)
    private let bellButton = UIBarButtonItem(image: Images.bellImage, style: .plain, target: nil, action: nil)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        setUpTableView()
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
    
    private func setUpTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.dataSource = self
    }
    
}

// MARK: - TableView DataSource

extension NeighborhoodVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let randomStr = String(repeating: "안녕하세요 홍경표입니다. 호호 ㅁㄴㅇㄹ ", count: Int.random(in: 1...4))
        cell.configure(text: randomStr, index: indexPath.row)
        return cell
    }
    
}
