#!/bin/bash
cd ../../
pwd
# pod install

# cd ..
flutter clean
flutter build ios --release -t lib/entries/staging.dart
cd -
