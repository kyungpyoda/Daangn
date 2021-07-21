//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍경표 on 2021/07/21.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "ThirdPartyManager",
    packages: [
        .RxSwift,
        .ReactorKit,
        .SnapKit,
        .Then,
    ],
    dependencies: [
        .SPM.RxSwift,
        .SPM.ReactorKit,
        .SPM.RxCocoa,
        .SPM.RxRelay,
        .SPM.RxBlocking,
        .SPM.SnapKit,
        .SPM.Then,
    ]
)
