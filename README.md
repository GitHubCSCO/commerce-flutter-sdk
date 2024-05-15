# Optimizely Configured Commerce Mobile UI SDK

## Introduction
The Optimizely Configured Commerce Mobile UI SDK is the foundation of a customizable native mobile app built using [Flutter](https://flutter.dev/) for Optimizely Configured Commerce. 

## Table of contents
- [Setup](#setup)
   - [Prerequisites](#prerequisites) 
   - [Before you run](#before-you-run) 
- [Configure and extend your app](#configure-and-extend-your-mobile-app)
- [Change client id](#change-client-id)
- [Run your app locally](#run-your-app-locally)
- [Deploy your app publicly](#deploy-your-app-publicly)

## Setup
### Prerequisites
Before running the Flutter application, ensure that you have the following prerequisites installed:

- **Flutter SDK:** Visit [Flutter Installation Guide](https://flutter.dev/docs/get-started/install) for installation instructions.
- **Flutter compatible IDE:** Install Android Studio, Visual Studio Code, or any other IDE compatible with Flutter development.
- **Device Emulator or Physical Device:** You can use either an Android emulator, iOS simulator, or a physical device connected to your development machine. But to test some of the features such as barcode scanning you need real device.
- **Xcode**
- **Apple Developer account**
- **Android sdk**
- **Access to [Commerce Dart Sdk](https://github.com/Optimizely-Access/commerce-dart-sdk)**

## Before you run
- Fix **optimizely_commerce_api** in pubspec.yaml file.
- Change `git@github.com:InsiteSoftware/commerce-dart-sdk.git` git url to  your copy of the commerce dart sdk.
- Change branch `ref:  develop` to `ref:  main`

### Configure and extend your app
The app verifies that the Domain string is set in the `Configuration.json` file upon launch. The app will use that value as the host for all requests if it is set. Otherwise, you are prompted in the app to enter a Domain URL for the app to use.

## Change client id
- To change or update clientId and clientSecret checkout `main.dart` initCommerceSDK.
```dart
void initCommerceSDK() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}
```

## Run your app locally
- `flutter run`

## Deploy your app publicly
Distribute your application to users after you complete your customizations and updates by deploying it to the Apple App Store (iOS), Google Play Store (Android), or both. To do so, follow these instructions:
- For android: `flutter build appbundle`
- For ios: `flutter build ipa`
- [Apple App Store Connect](https://help.apple.com/app-store-connect/#/dev300c2c5bf)
- [Google Play Store Play Console](https://support.google.com/googleplay/android-developer/answer/9859152)