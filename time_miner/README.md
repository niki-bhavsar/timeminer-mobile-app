# time_miner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


##### 1. Download packages
  ```sh
  flutter pub get
  ```

##### 2. Generate localization resources
  ```sh
  flutter gen-l10n
  ```

##### 3. Run Android App
  ```sh
  flutter run --flavor prod
  ```

##### 4. Run iOS App
  ```sh
  flutter run --flavor Compass[PROD]
  ```

## Code Guidelines

##### 1. Performs static code analysis
  ```sh
  dart analyze --fatal-infos
  ```

##### 2. Check Dart formatting guidelines
  ```sh
  dart format --line-length 100 lib
  ```


## Tech stack & 3rd Party libraries
- iOS
    - Minimum SDK level 13
- Objective-C
- DynamSoft v9.6.10 for Barcode Scanning (GS1-128 Barcode format)
- Firebase Analytics, Crashlytics & Performance Monitoring
