# iw.internal-ios-sdk

A device fingerprinting SDK for iOS that collects device metrics and sends them to your backend.

## Requirements

- iOS 15.0+
- Swift 5.7+
- Xcode 14.0+

## Installation

### Swift Package Manager

Add the package to your project using Xcode:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:

    ```text
    https://github.com/Saidazizkhon05/iw.internal-ios-sdk
    ```

4. Select the version you want
5. Click **Add Package**

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Saidazizkhon05/iw.internal-ios-sdk.git", from: "0.1.0")
]
```

Then add the dependency to your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["TestFingerprintSDK"]
)
```

## Usage

### 1. Import the SDK

```swift
import TestFingerprintSDK
```

### 2. Configure the SDK

Configure the SDK at app launch with your project ID:

```swift
import SwiftUI
import TestFingerprintSDK

@main
struct MyApp: App {
    
    init() {
        InnerworksSDK.configure(projectId: "your-project-id")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

#### Configuration Options

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `projectId` | `String` | Yes | Your unique project identifier |

**With custom API URL:**

```swift
InnerworksSDK.configure(projectId: "your-project-id")
```

### 3. Send Device Metrics

Call `send()` to collect and send device metrics:

```swift
do {
    try await InnerworksSDK.send(userId: "user@example.com")
    print("Metrics sent successfully")
} catch {
    print("Failed to send metrics: \(error.localizedDescription)")
}
```

#### Parameters

| Parameter | Type      | Required | Description                                                         |
|-----------|-----------|----------|---------------------------------------------------------------------|
| `userId`  | `String?` | No       | Optional user identifier. If not provided, a UUID will be generated |

### Complete Example

```swift
import SwiftUI
import TestFingerprintSDK

struct ContentView: View {
    @State private var email = ""
    @State private var isSending = false
    @State private var errorMessage: String?
    @State private var isSuccess = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            Button(action: sendMetrics) {
                if isSending {
                    ProgressView()
                } else {
                    Text("Send Metrics")
                }
            }
            .disabled(email.isEmpty || isSending)
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            if isSuccess {
                Text("Metrics sent successfully!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
    
    func sendMetrics() {
        Task {
            isSending = true
            defer { isSending = false }
            
            do {
                try await InnerworksSDK.send(userId: email)
                isSuccess = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
```

## Permissions (Optional)

For enhanced fingerprinting accuracy, you may request the following permissions:

- **Camera** - For camera hardware detection
- **Location** - For location-based metrics

Add these keys to your `Info.plist` if needed:

```xml
<key>NSCameraUsageDescription</key>
<string>Used for device identification</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Used for device identification</string>
```

## Error Handling

The SDK throws errors when:

- SDK is not configured before calling `send()`
- Network request fails
- API returns an error

```swift
do {
    try await InnerworksSDK.send(userId: "user@example.com")
} catch {
    switch error {
    case SDKError.notConfigured:
        print("SDK not configured. Call configure() first.")
    default:
        print("Error: \(error.localizedDescription)")
    }
}
```

## Thread Safety

All SDK methods are thread-safe and can be called from any thread. The `send()` method is async and should be called with `await`.

