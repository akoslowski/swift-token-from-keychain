// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-token-from-keychain",
    products: [
        .library(
            name: "TokenFromKeychain",
            targets: ["TokenFromKeychain"]
        ),
    ],
    targets: [
        .target(
            name: "TokenFromKeychain"
        ),
        .testTarget(
            name: "TokenFromKeychainTests",
            dependencies: ["TokenFromKeychain"]
        ),
    ]
)
