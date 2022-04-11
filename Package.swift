// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SwiftUIMapView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "SwiftUIMapView", targets: ["SwiftUIMapView"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftUIMapView", dependencies: []),
        .testTarget(name: "SwiftUIMapViewTests", dependencies: ["SwiftUIMapView"]),
    ]
)
