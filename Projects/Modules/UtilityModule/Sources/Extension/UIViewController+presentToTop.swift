//
//  UIViewController+presentToTop.swift
//  UtilityModule
//
//  Created by 홍경표 on 2021/07/25.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

extension UIViewController {
    public func presentToTop(animated: Bool = true) {
        let currentTop = UIApplication.keyWindowOfCurrentScene?.topViewController
        self.modalPresentationStyle = .overFullScreen
        currentTop?.present(self, animated: animated, completion: nil)
    }
}
