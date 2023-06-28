// swift-tools-version:5.8
// Managed by ice

import PackageDescription

let package = Package(
    name: "Shout",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "Shout", targets: ["Shout"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Subito-it/BlueSocket", branch: "mendoza/stable"),
    ],
    targets: [
        .systemLibrary(name: "CSSH", pkgConfig: "libssh2", providers: [.brew(["libssh2","openssl"])]),
        .target(name: "Shout", dependencies: ["CSSH", .product(name: "Socket", package: "BlueSocket")]),
        .testTarget(name: "ShoutTests", dependencies: ["Shout"]),
    ]
)
