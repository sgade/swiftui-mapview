// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swiftui-mapview",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftUIMapView",
            targets: ["SwiftUIMapView"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIMapView",
            dependencies: []
        )
    ]
)
