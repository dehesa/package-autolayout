// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "package-autolayout",
  platforms: [
    .iOS(.v14),
    .tvOS(.v14),
    .macOS(.v11),
//    .visionOS(.v1)
  ],
  products: [
    .library(name: "Autolayout", targets: ["Autolayout"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Autolayout",
      dependencies: [],
      path: "Sources"
    ),
    .testTarget(
      name: "AutolayoutTests",
      dependencies: ["Autolayout"],
      path: "Tests"
    )
  ]
)
