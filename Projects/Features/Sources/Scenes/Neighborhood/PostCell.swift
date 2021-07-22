//
//  PostCell.swift
//  Features
//
//  Created by 홍경표 on 2021/07/22.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
    
    private let inset: CGFloat = 12
    
    private let containerView: UIStackView = .init().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.backgroundColor = .systemBackground
    }
    private let categoryLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .caption2)
        $0.textColor = .darkGray
        $0.backgroundColor = .systemGray6
        $0.text = " 일상 "
    }
    private let contentsLabel: UILabel = .init().then {
        $0.numberOfLines = 3
        $0.font = .preferredFont(forTextStyle: .body)
        $0.text = """
                  안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다. 안녕하세요 홍경표입니다.
                  """
    }
    private let contentsImageView: UIImageView = .init().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "cloud.rain")
        $0.backgroundColor = .systemGray5
        $0.isHidden = true
    }
    private let userInfoLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .systemGray
        $0.text = "홍경표 · 강서구 마곡동"
    }
    private let dateLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .systemGray
        $0.text = "1시간 전"
    }
    
    private let reactionButton: UIButton = .init().then {
        $0.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.setTitle("🙂 공감하기", for: .normal)
    }
    private let commentLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .darkGray
        $0.text = "💬 댓글"
    }
    private let reactionCountLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.text = "👍1"
    }
    
    // 레이아웃 구성을 위한 뷰들.
    private let lineView = UIView().then { $0.backgroundColor = .systemGray5 }
    private lazy var categoryView = UIView().then {
        $0.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
    private lazy var infoViews = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.alignment = .fill
        $0.addArrangedSubview(userInfoLabel)
        $0.addArrangedSubview(dateLabel)
    }
    private lazy var bottomViews = UIView().then {
        $0.addSubview(reactionButton)
        $0.addSubview(commentLabel)
        $0.addSubview(reactionCountLabel)
        reactionButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        commentLabel.snp.makeConstraints {
            $0.leading.equalTo(reactionButton.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        reactionCountLabel.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .clear
        
        selectionStyle = .none
        
        self.layoutMargins = .zero
        self.separatorInset = .zero
        self.preservesSuperviewLayoutMargins = false
        
        containerView.addArrangedSubview(categoryView)
        containerView.addArrangedSubview(contentsLabel)
        containerView.addArrangedSubview(contentsImageView)
        containerView.addArrangedSubview(infoViews)
        containerView.addArrangedSubview(lineView)
        containerView.addArrangedSubview(bottomViews)
        
        categoryView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(40)
        }
        contentsLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
        }
        contentsImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(containerView.snp.width).multipliedBy(0.6)
        }
        infoViews.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(40)
        }
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        bottomViews.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(text: String, index: Int) {
        contentsLabel.text = text
        contentsImageView.isHidden = index % 2 == 0
    }
    
    override func prepareForReuse() {
        contentsLabel.text = ""
        contentsImageView.isHidden = true
    }
    
}
