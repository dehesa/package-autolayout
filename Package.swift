// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "dehesa-autolayout",
  platforms: [
    .iOS(.v12),
    .tvOS(.v12),
    .macOS(.v10_15),
//    .visionOS(.v1)
  ],
  products: [
    .library(name: "Autolayout", targets: ["Autolayout"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "Autolayout", dependencies: []),
//    .testTarget(name: "AutolayoutTests", dependencies: ["Autolayout"])
  ]
)
