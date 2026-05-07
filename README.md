# Patrol Webinar

Sample conference app used for Patrol webinars and live streams. The project shows how to write E2E tests for realistic Flutter user flows: onboarding, login, agenda browsing, speakers, session details, and native interactions such as permissions or maps.

## Running the App

Requirements:

- Flutter matching the version range from `pubspec.yaml` (`>=3.41.0 <4.0.0`)
- Android Studio or Xcode with a running emulator/simulator

Install dependencies:

```sh
flutter pub get
```

Run the development flavor:

```sh
flutter run --flavor dev -t lib/main_dev.dart
```

Run the test flavor, which is also used by Patrol:

```sh
flutter run --flavor tst -t lib/main_tst.dart
```

## Google Maps API Key

The app uses Google Maps, so before opening map screens you need to provide an API key with the Google Maps SDK enabled for Android and/or iOS.

Android: replace `<YOUR_API_KEY>` in `android/app/build.gradle` for the `dev` and `tst` flavors:

```gradle
manifestPlaceholders = [
    appLabel: "FTS DEV",
    authHostName: "auth.patrol-webinar.test.lncd.pl",
    googleMapsApiKey: "<YOUR_API_KEY>"
]
```

iOS: replace `<YOUR_API_KEY>` in `ios/Runner/AppDelegate.swift`:

```swift
GMSServices.provideAPIKey("<YOUR_API_KEY>")
```

Do not commit a real key if the repository is public or shared outside a trusted team.

## Running Patrol Tests

First, install the Patrol CLI:

```sh
dart pub global activate patrol_cli
```

Run all tests:

```sh
patrol test
```

Run a single scenario:

```sh
patrol test -t patrol_test/scenarios/login_logout_test.dart
```

Some scenarios require data passed through `--dart-define`, for example a test account or Mailpit access:

```sh
patrol test -t patrol_test/scenarios/login_logout_test.dart \
  --dart-define=EMAIL="user@example.com" \
  --dart-define=PASSWORD="password"
```

Variables used by the tests include `EMAIL`, `PASSWORD`, `FIRSTNAME`, `LASTNAME`, `DOMAIN_NAME`, `MAILPIT_LOGIN`, `MAILPIT_PASSWORD`, and `MAILBOX_API_KEY`.
