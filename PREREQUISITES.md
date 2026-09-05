# Before the workshop

Do this the evening before — the Gradle/CocoaPods caching and the emulator
image download are slow.

## 1. Repo

```sh
git clone https://github.com/leancodepl/patrol-webinar
cd patrol-webinar
```

## 2. Flutter 3.41.7

Pinned in `.fvmrc`. On fvm: `fvm install`. Otherwise: `flutter version 3.41.7`.
Prefix every command below with `fvm` if you use it.

```sh
flutter pub get
flutter build apk --flavor tst -t lib/main_tst.dart              # Android
flutter build ios --flavor tst -t lib/main_tst.dart --no-codesign  # iOS
```

**Checkpoint:** the build finishes.

## 3. Patrol CLI

Comes from the lockfile, so there's nothing to install — run it through the
project. Needs a device: an Android emulator (API 28+) or an iOS 15+ simulator.

```sh
dart run patrol_cli:main test -t patrol_test/scenarios/login_browse_agenda_test.dart -d <device-id>
```

**Checkpoint:** the test passes. No account, API keys or `.patrol.env` needed.

## 4. AI tool

Bring one with active API credits (Claude Code recommended). `.mcp.json`
already wires up the Patrol and Marionette MCP servers.

## Known, expected, not a bug

- With more than one device attached, `patrol_cli` prompts for one unless you
  pass `-d`. `flutter devices` lists ids.
- Map screens render as a grey rectangle — no Google Maps API key configured.
- During the session you'll `git checkout` a branch per exercise. Leave `main`
  as is.
