# Optimizely Configured Commerce Mobile UI SDK

## Introduction

The Optimizely Configured Commerce Mobile UI SDK is the foundation of a customizable native mobile app built using [Flutter](https://flutter.dev/) for Optimizely Configured Commerce.

## Table of contents

- [Optimizely Configured Commerce Mobile UI SDK](#optimizely-configured-commerce-mobile-ui-sdk)
  - [Introduction](#introduction)
  - [Table of contents](#table-of-contents)
  - [Setup](#setup)
    - [Prerequisites](#prerequisites)
  - [Before you run](#before-you-run)
    - [Configure and extend your app](#configure-and-extend-your-app)
  - [Change client id](#change-client-id)
  - [To see logs when running the app](#to-see-logs-when-running-the-app)
  - [Run your app locally](#run-your-app-locally)
  - [Deploy your app publicly](#deploy-your-app-publicly)

## Setup

### Prerequisites

Before running the Flutter application, ensure that you have the following prerequisites installed:

- **Flutter SDK 3.32.0:** Visit [Flutter Installation Guide](https://flutter.dev/docs/get-started/install) for installation instructions.
- **Flutter compatible IDE:** Install Android Studio, Visual Studio Code, or any other IDE compatible with Flutter development.
- **Device Emulator or Physical Device:** You can use either an Android emulator, iOS simulator, or a physical device connected to your development machine. But to test some of the features such as barcode scanning you need real device.
- **Xcode 16.4**
- **Apple Developer account**
- **Android sdk (android-35, build-tools 35.0.0)**

## Before you run
### Configure and extend your app

The app verifies that the `domain` string is set in the `base_config.json`(located in `assets/config` folder) file upon launch. The app will use that value as the host for all requests if it is set. Otherwise, you are prompted in the app to enter a Domain URL for the app to use.

## Change client id

- To change or update clientId and clientSecret checkout `main.dart` initCommerceSDK.

```dart
void initCommerceSDK() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}
```

## To see logs when running the app

- Find the code block in `lib/core/injection/injection_container.dart`.

```dart
    ..registerLazySingleton<OptiLoggerService>(() => OptiLogger(
          enableApiLog: false,
          enableDebugLog: false,
          enableErrorLog: false,
        ))
```

- To see log produced in the api sdk turn `enableApiLog` to `true`
- To see debug log from different libraries and/or from the app turn `enableDebugLog` to `true`
- To see error log turn `enableErrorLog` to `true`

## Run your app locally

- `flutter run`

## Deploy your app publicly

Distribute your application to users after you complete your customizations and updates by deploying it to the Apple App Store (iOS), Google Play Store (Android), or both. To do so, follow these instructions:

- For android: `flutter build appbundle` or `flutter build apk`
- For ios: `flutter build ipa`
- [Apple App Store Connect](https://help.apple.com/app-store-connect/#/dev300c2c5bf)
- [Google Play Store Play Console](https://support.google.com/googleplay/android-developer/answer/9859152)
