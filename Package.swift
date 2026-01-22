// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "TestFingerprintSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "TestFingerprintSDK", targets: ["TestFingerprintSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "TestFingerprintSDK",
            url: "https://github.com/YOUR_ORG/TestFingerprintSDK/releases/download/1.0.0/TestFingerprintSDK.xcframework.zip",
            checksum: "YOUR_CHECKSUM_HERE"
        )
    ]
)
