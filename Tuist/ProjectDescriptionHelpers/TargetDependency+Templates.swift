//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍경표 on 2021/07/21.
//

import ProjectDescription

public extension TargetDependency {
    static let features: TargetDependency = .project(target: "Features",
                                                     path: .relativeToRoot("Projects/Features"))
    static let coreKit: TargetDependency = .project(target: "CoreKit",
                                                    path: .relativeToRoot("Projects/Modules/CoreKit"))
    static let thirdPartyManager: TargetDependency = .project(target: "ThirdPartyManager",
                                                              path: .relativeToRoot("Projects/Modules/ThirdPartyManager"))
    static let utilityModule: TargetDependency = .project(target: "UtilityModule",
                                                          path: .relativeToRoot("Projects/Modules/UtilityModule"))
}

// SPM
public extension TargetDependency {
    struct SPM {
        public static let RxSwift = TargetDependency.package(product: "RxSwift")
        public static let RxCocoa = TargetDependency.package(product: "RxCocoa")
        public static let RxRelay = TargetDependency.package(product: "RxRelay")
        public static let RxBlocking = TargetDependency.package(product: "RxBlocking")
        public static let ReactorKit = TargetDependency.package(product: "ReactorKit")
        public static let SnapKit = TargetDependency.package(product: "SnapKit")
        public static let Then = TargetDependency.package(product: "Then")
    }
}
public extension Package {
    static let RxSwift = Package.remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "5.0.0"))
    static let ReactorKit = Package.remote(url: "https://github.com/ReactorKit/ReactorKit", requirement: .upToNextMajor(from: "2.1.1"))
    static let SnapKit = Package.remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1"))
    static let Then = Package.remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.7.0"))
}
