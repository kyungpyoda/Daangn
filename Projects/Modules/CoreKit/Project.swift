//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍경표 on 2021/07/21.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "CoreKit",
    dependencies: [
        .thirdPartyManager,
    ]
)
