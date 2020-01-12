# Daikin

Daikin project on the FLUTTER platform

## How to build Android

1. Make clean and refresh pub libs
2. `flutter build appbundle --release -t lib/entries/staging.dart`
3. `flutter build appbundle --release -t lib/entries/production.dart`

## How to build iOS

1. Clean and refresh pub libs
2. cd ios and pod get/install
3. cd ..
4. `flutter build ios lib/entries/production.dart`
5. Using xcode or build and release

// **\* PLEASE RUN COMMAND BELOW FOR REBUILD MODELS \*\***
// flutter packages pub run build_runner build --delete-conflicting-outputs

flutter build apk --release -t lib/entries/staging.dart
flutter build apk --release -t lib/entries/production.dart
