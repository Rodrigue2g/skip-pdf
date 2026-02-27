// swift-tools-version: 6.1
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "skip-pdf",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "SkipPDF", type: .dynamic, targets: ["SkipPDF"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.7.1"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "1.1.11"),
    ],
    targets: [
        .target(name: "SkipPDF", dependencies: [
            .product(name: "SkipFoundation", package: "skip-foundation")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipPDFTests", dependencies: [
            "SkipPDF",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
