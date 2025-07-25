// swift-tools-version:6.1
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
      path: "Sources",
      swiftSettings: .customSettings() 
    ),
    .testTarget(
      name: "AutolayoutTests",
      dependencies: ["Autolayout"],
      path: "Tests",
      swiftSettings: .customSettings()
    )
  ],
  swiftLanguageModes: [.v6]
)

// MARK: -

private extension [SwiftSetting] {
  static func customSettings(typeChecking: Int = 30, functionBodies: Int = 80) -> Self {
    // Slow compilation warnings
    var result: Self = [
      .unsafeFlags([
        "-Xfrontend", "-warn-long-expression-type-checking=\(typeChecking)",
        "-Xfrontend", "-warn-long-function-bodies=\(functionBodies)",
      ], .when(configuration: .debug))
    ]

    // Force the usage of the keyword `any` when referencing protocols
    #if !hasFeature(ExistentialAny)
    result.append(.enableUpcomingFeature("ExistentialAny"))
    #endif // https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md

    // Changes the default package import visibility from public to internal
    #if !hasFeature(InternalImportsByDefault)
    result.append(.enableUpcomingFeature("InternalImportsByDefault"))
    result.append(.enableExperimentalFeature("AccessLevelOnImport"))
    #endif // https://github.com/apple/swift-evolution/blob/main/proposals/0409-access-level-on-imports.md

    // Changes the visibility of imported module functionality (making it more strict and explicit).
    #if !hasFeature(MemberImportVisibility)
    result.append(.enableUpcomingFeature("MemberImportVisibility"))
    #endif

    // Introduce isolated conformances (i.e. conform to protocols, such as Equatable, on actors or global actor isolated types without nonisolated).
//    #if !hasFeature(InferIsolatedConformances)
//    result.append(.enableUpcomingFeature("InferIsolatedConformances"))
//    #endif // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0470-isolated-conformances.md

    // Changes the default behavior of nonisolated async functions from @concurrent to nonisolated(nonsending).
//    #if !hasFeature(NonisolatedNonsendingByDefault)
//    result.append(.enableUpcomingFeature("NonisolatedNonsendingByDefault"))
//    #endif // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0461-async-function-isolation.md

    return result
  }
}
