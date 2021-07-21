//
//  LaunchVC.swift
//  Features
//
//  Created by 홍경표 on 2021/07/21.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit
import CoreKit

public final class LaunchVC: UIViewController {
    
    private let logoImageView: UIImageView = .init().then {
        $0.image = CoreKitAsset.logoHorizontal.image
        $0.contentMode = .scaleAspectFit
    }
    private let titleLabel: UILabel = .init().then {
        $0.font = .preferredFont(forTextStyle: .title2)
        $0.textColor = CoreKitAsset.daangnOrange.color
        $0.textAlignment = .center
        $0.text = "글로벌 프로덕트 iOS 개발자 인턴\n클론과제 by 홍경표"
        $0.numberOfLines = 2
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("All UIs are code based, not nib.")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Coordinator.goMain()
        }
    }
    
    private func setUp() {
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
