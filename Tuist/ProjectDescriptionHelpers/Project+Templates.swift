//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍경표 on 2021/07/21.
//

import ProjectDescription

public extension Project {
    static func framework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        dependencies: [TargetDependency] = []
    ) -> Self {
        return project(
            name: name,
            packages: packages,
            product: .framework,
            platform: platform,
            dependencies: dependencies
        )
    }
}

public extension Project {
    static func project(
        name: String,
        organizationName: String = "pio",
        packages: [Package] = [],
        product: Product,
        platform: Platform = .iOS,
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "13.0", devices: .iphone),
        actions: [TargetAction] = [],
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        settings: Settings? = nil,
        schemes: [Scheme] = []
    ) -> Self {
        let mainTarget: Target = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "kr.pio.\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            actions: actions,
            dependencies: dependencies
        )
        
        let testTarget: Target = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "kr.pio.\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        let targets: [Target] = [
            mainTarget,
            testTarget
        ]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            targets: targets,
            schemes: schemes
        )
    }
}
