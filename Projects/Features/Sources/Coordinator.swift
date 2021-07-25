//
//  Coordinator.swift
//  Features
//
//  Created by 홍경표 on 2021/07/21.
//  Copyright © 2021 pio. All rights reserved.
//

import UIKit
import ThirdPartyManager
import UtilityModule
import SnapKit
import Then

public class Coordinator {
    
    private static let window: UIWindow? = UIApplication.shared.delegate?.window ?? nil
    
    private static func swapVC(to vc: UIViewController) {
        window?.rootViewController = vc
    }
    
    public static func launch() {
        swapVC(to: LaunchVC())
    }
    
    static func goMain() {
        swapVC(to: MainTabBarController())
    }
    
}
