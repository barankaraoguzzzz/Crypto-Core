// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CryptoCore",
    platforms: [
      .macOS(.v10_15),
      .iOS(.v13),
    ],
    products: [
      .library(name: "CryptoCore", targets: ["CryptoCore"]),
    ],
    dependencies: [
        // 🔑 Hashing (BCrypt, SHA2, HMAC), encryption (AES), public-key (RSA), and random data generation.
        .package(url: "https://github.com/apple/swift-crypto.git", .branch("main")),
    ],
    targets: [
        // 👀 C helpers
        .target(name: "keccaktiny", cSettings: [
            .define("memset_s(W,WL,V,OL)=memset(W,V,OL)", .when(platforms: [.linux], configuration: nil))
        ]),

        // 🎯 Target -- Base58
        .target(name: "Base58", dependencies: [
            .product(name: "Crypto", package: "swift-crypto"),
        ]),

        // 🎯 Target -- CryptoCore
        .target(name: "CryptoCore", dependencies: [
            "keccaktiny",
            "Base58",
        ]),

        // Test -- CryptoCore
        .testTarget(name: "CryptoCoreTests", dependencies: [
            "CryptoCore"
        ]),
    ],
    swiftLanguageVersions : [.v5]
)

