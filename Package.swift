// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Autolayout",
    platforms: [
        .iOS(.v12), .tvOS(.v12), .macOS(.v10_15)
    ],
    products: [
        .library(name: "Autolayout", targets: ["Autolayout"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Autolayout", dependencies: []),
        .testTarget(name: "AutolayoutTests", dependencies: ["Autolayout"]),
    ]
)
