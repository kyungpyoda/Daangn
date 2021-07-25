//
//  UIWindow+topViewController.swift
//  UtilityModule
//
//  Created by 홍경표 on 2021/07/25.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

extension UIWindow {
    public var topViewController: UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

