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
            url: "https://github.com/Saidazizkhon05/iw.internal-ios-sdk/releases/download/0.1.0/TestFingerprintSDK.xcframework.zip",
            checksum: "bed325eca8b07df9d21928dd37ff6de3c01df1f551956dad9f075b9f292a75dc"
        )
    ]
)
