//
//  UIApplication+keyWindow.swift
//  UtilityModule
//
//  Created by 홍경표 on 2021/07/25.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit

extension UIApplication {
    public class var keyWindowOfCurrentScene: UIWindow? {
        shared.windows.first(where: { $0.isKeyWindow })
    }
}
