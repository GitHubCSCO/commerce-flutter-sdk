flu# Optimizely Configured Commerce Mobile UI SDK

The Optimizely Configured Commerce Mobile UI SDK is the foundation of a customizable native mobile app built with [Flutter](https://flutter.dev/) for Optimizely Configured Commerce. It ships as a base codebase that B2B customers fork and tailor to their brand.

## Table of contents

- [Prerequisites](#prerequisites)
- [Project structure](#project-structure)
- [Setup](#setup)
- [Configure](#configure)
  - [Domain](#domain)
  - [Firebase and AppCenter credentials](#firebase-and-appcenter-credentials)
  - [Client ID and secret](#client-id-and-secret)
- [Enable logging](#enable-logging)
- [Run the app](#run-the-app)
- [Run the tests](#run-the-tests)
- [Build and deploy](#build-and-deploy)
- [Troubleshooting](#troubleshooting)
- [Further reading](#further-reading)

## Prerequisites

Install the following before building the app. The table below mirrors the versions the repo actually pins — the source of truth lives in `pubspec.yaml`, `android/gradle/wrapper/gradle-wrapper.properties`, `ios/Podfile`, and the CI workflows under `.github/workflows/`. If a value here ever disagrees with those files, trust the files.

| Tool | Version | Notes |
| --- | --- | --- |
| Flutter SDK | **3.38.0** | Minimum pinned in `pubspec.yaml` (`environment.flutter`); CI resolves it via `flutter-version-file`. Newer stable patch releases (e.g. 3.38.x) are fine. See the [Flutter install guide](https://docs.flutter.dev/get-started/install). |
| Dart SDK | **>=3.5.0 <4.0.0** | Ships with the matching Flutter SDK. |
| Xcode | **26.3** | Required for iOS builds. Pinned in CI (`.github/workflows/*.yml`); newer 26.x releases also work. |
| iOS deployment target | **15.5** | Set in `ios/Podfile`. |
| CocoaPods | latest stable | Install with `sudo gem install cocoapods` if not already present. |
| Android `minSdkVersion` | **24** | Set in `android/app/build.gradle`. |
| Android `compileSdk` / `targetSdk` | managed by Flutter | Driven by `flutter.compileSdkVersion` / `flutter.targetSdkVersion`; no manual SDK Manager pinning required beyond what `flutter doctor` reports. |
| Gradle | **8.11.1** | Wrapped via `android/gradle/wrapper/gradle-wrapper.properties` — no separate install needed. |
| JDK | **17** | Matches the release builds in `.github/workflows/android.yml`. Zulu or Temurin distributions both work. |
| IDE | Android Studio, VS Code, or any Flutter-compatible IDE | — |
| Device | Android emulator, iOS simulator, or physical device | A physical device is required to test camera-based features such as barcode scanning. |
| Apple Developer account | — | Required for signing iOS builds and publishing to the App Store. |
| Mason CLI | latest stable | Only needed if you plan to regenerate `assets/config/base_config.json` from the included [bricks](./bricks). Install via `scripts/mason_installer.sh`. |

Run `flutter doctor` after installing Flutter to confirm your toolchain is healthy before continuing.

## Project structure

The repo bundles its API client as a sibling folder rather than a published package:

- [`lib/`](./lib) — the Flutter UI SDK source. App entry point is [`lib/main.dart`](./lib/main.dart).
- [`commerce-dart-sdk/`](./commerce-dart-sdk) — the `optimizely_commerce_api` Dart SDK, included as a path dependency in `pubspec.yaml`. See its own [README](./commerce-dart-sdk/README.md) for API usage.
- [`test/`](./test) — widget and unit tests, organized under `test/features/` and `test/sdk/`.
- [`assets/config/base_config.json`](./assets/config/base_config.json) — runtime configuration loaded at app launch.
- [`bricks/`](./bricks) and [`scripts/`](./scripts) — Mason bricks and helper scripts for regenerating config.
- [`docs/`](./docs) — architecture and customization guides.

## Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/InsiteSoftware/commerce-flutter-sdk.git
   cd commerce-flutter-sdk
   ```
2. Fetch Dart/Flutter dependencies (this also wires up the bundled `commerce-dart-sdk`):
   ```bash
   flutter pub get
   ```
3. Install iOS pods (macOS only):
   ```bash
   cd ios && pod install && cd ..
   ```
4. Configure the app — see [Configure](#configure) below.
5. (Optional) If you need to regenerate the bundled config from the Mason brick, install Mason and run the updater:
   ```bash
   bash scripts/mason_installer.sh
   bash scripts/config_updater.sh
   ```
6. (Optional, only when editing JSON-serializable models) Regenerate `*.g.dart` files. The committed `.g.dart` files already cover the existing models, so this is only needed if you add or change a `@JsonSerializable` class:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## Configure

Configuration lives in [`assets/config/base_config.json`](./assets/config/base_config.json) and is read on app launch.

### Domain

If `domain` is set, the app uses it as the host for all requests. If it is empty, the app prompts the user for a Domain URL on first launch.

### Firebase and AppCenter credentials

> **Important for downstream forks:** the Firebase and AppCenter keys committed to `base_config.json` belong to the base SDK's dev/test project. Before publishing a customer app you must replace them with credentials from your own Firebase project and AppCenter app. The keys to swap are:
>
> - `firebaseAndroidApiKey`, `firebaseAndroidAppId`, `firebaseAndroidMessagingSenderId`, `firebaseAndroidProjectId`, `firebaseAndroidStorageBucket`
> - `firebaseIOSApiKey`, `firebaseIOSAppId`, `firebaseIOSMessagingSenderId`, `firebaseIOSProjectId`, `firebaseIOSStorageBucket`, `firebaseIOSBundleId`
> - `appCenterSecretiOS`, `appCenterSecretAndroid`
>
> Leaving these as-is in a production build will route push notifications and analytics to the wrong project.

### Client ID and secret

The client ID and client secret are set in [`lib/src/initializers/commerce_sdk_initializer.dart`](./lib/src/initializers/commerce_sdk_initializer.dart). Update the values referenced by `ProdConfigConstants` to override them:

```dart
class CommerceSdkInitializer {
  void init() {
    ClientConfig.hostUrl = null;
    ClientConfig.clientId = ProdConfigConstants.clientId;
    ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
  }
}
```

## Enable logging

The logger is registered in [`lib/src/core/injection/injection_container.dart`](./lib/src/core/injection/injection_container.dart). Flip the flags to surface logs in your debug console:

```dart
..registerLazySingleton<OptiLoggerService>(
  () => OptiLogger(
    enableApiLog: false,
    enableDebugLog: false,
    enableErrorLog: false,
  ),
)
```

- `enableApiLog` — logs requests/responses from the API SDK.
- `enableDebugLog` — logs debug output from the app and libraries.
- `enableErrorLog` — logs errors.

## Run the app

```bash
flutter run
```

## Run the tests

Tests live under [`test/`](./test) (widget and unit tests) and are executed by the `Run all tests` CI job on every PR.

```bash
flutter test                      # run the full suite
flutter test test/features/cart   # run a subdirectory
flutter test --coverage           # write coverage to coverage/lcov.info
```

## Build and deploy

After your customizations are complete, build release artifacts and submit them to the stores.

### Signing

Release builds require signing — debug builds do not.

- **Android**: create `android/key.properties` alongside the keystore it points to. [`android/app/build.gradle`](./android/app/build.gradle) reads `keyAlias`, `keyPassword`, `storeFile`, and `storePassword` from this file. See Flutter's [Android deployment guide](https://docs.flutter.dev/deployment/android#sign-the-app) for the keystore creation steps.
- **iOS**: open `ios/Runner.xcworkspace` in Xcode, select the Runner target, and set your team and signing certificate under *Signing & Capabilities*. See Flutter's [iOS deployment guide](https://docs.flutter.dev/deployment/ios) for the full workflow.

### Build commands

- Android:
  ```bash
  flutter build appbundle   # for Play Store
  flutter build apk         # for direct distribution
  ```
- iOS:
  ```bash
  flutter build ipa
  ```

### Submission guides

- [App Store Connect help](https://developer.apple.com/help/app-store-connect/)
- [Google Play Console help](https://support.google.com/googleplay/android-developer/answer/9859152)

## Troubleshooting

- **CocoaPods errors after a Flutter or dependency upgrade** — run `pod repo update && pod install` from the `ios/` directory.
- **Stale build artifacts after upgrading Flutter or dependencies** — run `flutter clean && flutter pub get` before rebuilding.
- **`Unsupported class file major version` or Gradle JVM errors** — confirm your `JAVA_HOME` points to JDK 17.
- **`flutter pub get` cannot find `optimizely_commerce_api`** — make sure the `commerce-dart-sdk/` directory is present at the repo root; it is a path dependency, not a pub.dev package.

## Further reading

- [Architecture guide](./docs/ARCHITECTURE.md) — clean-architecture layers, state management, and directory layout.
- [Customization guide](./docs/CUSTOMIZATION.md) — safe extension patterns for downstream forks.
- [`commerce-dart-sdk` README](./commerce-dart-sdk/README.md) — API client usage and configuration.
