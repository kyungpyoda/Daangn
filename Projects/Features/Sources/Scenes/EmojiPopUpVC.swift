//
//  EmojiPopUpVC.swift
//  Features
//
//  Created by 홍경표 on 2021/07/25.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

final class EmojiPopUpVC: UIViewController {
    
    private enum Constants {
        static let popUpViewHeight: CGFloat = 40
    }
    
    let popUpPosition: CGPoint?
    
    private lazy var emojiContainer: UIStackView = .init().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 8
        
        $0.backgroundColor = .systemBackground
        
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        $0.layer.cornerRadius = Constants.popUpViewHeight / 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        
        let emojiButtons = ["🥕", "🐰", "❤️", "🔥", "👍"].map { emoji in
            return UIButton(type: .system).then {
                $0.setTitle(emoji, for: .normal)
                $0.titleLabel?.font = .preferredFont(forTextStyle: .title2)
            }
        }
        for btn in emojiButtons {
            $0.addArrangedSubview(btn)
        }
    }
    
    init(position: CGPoint? = nil) {
        self.popUpPosition = position
        
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        fatalError("All UIs are code based, not nib.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapBackground))
        view.addGestureRecognizer(tap)
        
        view.addSubview(emojiContainer)
        emojiContainer.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constants.popUpViewHeight)
            if let y = popUpPosition?.y {
                $0.top.equalToSuperview().offset(y)
            } else {
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let distanceToMove: CGFloat = (popUpPosition?.y == nil ? 0 : (popUpPosition!.y > 200 ? -45 : 45))
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) { [weak self] in
            self?.emojiContainer.transform = CGAffineTransform(translationX: 0, y: distanceToMove)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.emojiContainer.alpha = 0
            self?.emojiContainer.transform = .identity
        }
    }
    
    @objc private func onTapBackground() {
        dismiss(animated: true, completion: nil)
    }
    
}
