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
         .library(name: "Shout-Static", targets: ["Shout-Static"])
    ],
    dependencies: [
        .package(url: "https://github.com/Subito-it/BlueSocket", branch: "mendoza/stable"),
    ],
    targets: [
        .systemLibrary(name: "CSSH", pkgConfig: "libssh2", providers: [.brew(["libssh2","openssl@3"])]),
        .target(name: "Shout", dependencies: ["CSSH", .product(name: "Socket", package: "BlueSocket")]),
         .target(name: "CSSH-Static", publicHeadersPath: "."),
         .target(name: "Shout-Static",
                 dependencies: ["CSSH-Static", .product(name: "Socket", package: "BlueSocket")],
                 cSettings: [.unsafeFlags(["-I/usr/local/include/shout"])],
                 swiftSettings: [.unsafeFlags(["-I/usr/local/include/shout"])],
                 linkerSettings: [.unsafeFlags(["-L/usr/local/lib/shout", "-lssh2", "-lcrypto", "-lz"])]
                ),
         .testTarget(name: "ShoutTests", dependencies: ["Shout"]),
    ]
)
