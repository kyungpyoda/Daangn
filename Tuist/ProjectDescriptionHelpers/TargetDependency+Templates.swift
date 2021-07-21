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
}
