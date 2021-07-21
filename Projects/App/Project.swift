//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍경표 on 2021/07/21.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "Daangn"

let project = Project.project(
    name: projectName,
    product: .app,
    actions: [],
    dependencies: [
        .features
    ],
    infoPlist: "Supporting/Info.plist",
    schemes: []
)
