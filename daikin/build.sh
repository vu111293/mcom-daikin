



flutter clean
flutter packages get
cd ios
pod install
cd ..
flutter build apk --release -t lib/entries/staging.dart
flutter build ios --release -t lib/entries/staging.dart
