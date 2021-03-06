//
//  MainTabBarController.swift
//  Features
//
//  Created by 홍경표 on 2021/07/21.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit
import CoreKit

public final class MainTabBarController: UITabBarController {
    
    private enum Tab: CaseIterable {
        case home
        case neighborhood
        case near
        case chat
        case profile
        
        static let homeTabImage: UIImage? = nil
        static let neighborhoodTabImage: UIImage? = .init(systemName: "star.fill")
        static let nearTabImage: UIImage? = nil
        static let chatTabImage: UIImage? = nil
        static let profileTabImage: UIImage? = nil
        
        var tabBarItem: UITabBarItem {
            switch self {
            case .home:
                return .init(title: "홈",
                             image: Tab.homeTabImage,
                             selectedImage: Tab.homeTabImage)
                
            case .neighborhood:
                return .init(title: "동네생활",
                             image: Tab.neighborhoodTabImage,
                             selectedImage: Tab.neighborhoodTabImage)
                
            case .near:
                return .init(title: "내 근처",
                             image: Tab.nearTabImage,
                             selectedImage: Tab.nearTabImage)
                
            case .chat:
                return .init(title: "채팅",
                             image: Tab.chatTabImage,
                             selectedImage: Tab.chatTabImage)
                
            case .profile:
                return .init(title: "나의 당근",
                             image: Tab.profileTabImage,
                             selectedImage: Tab.profileTabImage)
            }
        }
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
    
    private func setUp() {
        let serviceProvider = ServiceProvider.shared
        
        let tabs: [UIViewController] = Tab.allCases.map { tab in
            switch tab {
            case .home:
                let vc = UIViewController()
                vc.view.backgroundColor = .systemBackground
                vc.tabBarItem = tab.tabBarItem
                return vc
                
            case .neighborhood:
                let vc = NeighborhoodVC(reactor: .init(provider: serviceProvider))
                vc.tabBarItem = tab.tabBarItem
                let navi = UINavigationController(rootViewController: vc)
                return navi
                
            case .near:
                let vc = UIViewController()
                vc.view.backgroundColor = .systemBackground
                vc.tabBarItem = tab.tabBarItem
                return vc
                
            case .chat:
                let vc = UIViewController()
                vc.view.backgroundColor = .systemBackground
                vc.tabBarItem = tab.tabBarItem
                return vc
                
            case .profile:
                let vc = UIViewController()
                vc.view.backgroundColor = .systemBackground
                vc.tabBarItem = tab.tabBarItem
                return vc
            }
        }
        
        setViewControllers(
            [tabs[1]],
            animated: false
        )
        
        tabBar.items?.forEach {
            $0.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        }
    }
    
}
