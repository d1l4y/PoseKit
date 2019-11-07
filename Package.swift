// swift-tools-version:5.0
//
//  poseKit.swift
//  poseKit
//
//  Created by Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva on 01/04/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "poseKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_10),
    ],
    products: [
        .library(
            name: "poseKit",
            targets: ["poseKit"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "poseKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "poseKitTests",
            dependencies: ["poseKit"],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
