# Before the workshop

Do this the evening before — the two slow steps (Gradle/CocoaPods caching and an
emulator image download) are exactly the ones you don't want to hit live.

## Flutter version

Pinned to **3.41.7** (`.fvmrc`). Switch to it however you normally manage
versions — `fvm install` if you're on fvm, `flutter version 3.41.7` otherwise.
Prefix the commands below with `fvm` in the fvm case.

## Setup

```sh
git clone https://github.com/leancodepl/patrol-webinar
cd patrol-webinar
flutter pub get
flutter build apk --flavor tst -t lib/main_tst.dart   # Android
# or
flutter build ios --flavor tst -t lib/main_tst.dart --no-codesign   # iOS
```

You'll also need a device: an Android emulator (API 28+, 34+ recommended) or
physical Android device, **or** Xcode with an iOS 15+ simulator or a physical
iPhone.

## Sanity-check

```sh
dart run patrol_cli:main test -t patrol_test/scenarios/login_browse_agenda_test.dart -d <device-id>
```

`patrol_cli` resolves from the lockfile (4.6.0) — don't `pub global activate`
it, a different global version pairs badly with `patrol: 4.8.0`.

It's a fresh install and pure browsing, no login — no test account, API keys,
or `.patrol.env` needed. If it **passes**, your environment is good.

Bring an AI coding tool with active API credits (Claude Code recommended).
`.mcp.json` already wires up the Patrol and Marionette MCP servers — opening
the repo root in your tool is all that's needed, no extra setup.

## Known, expected, not a bug

- **More than one device/simulator attached** (emulator + phone, or Chrome
  counting as a device) makes `patrol_cli test` prompt interactively for one
  unless you pass `-d`. From a non-interactive shell that prompt gets no
  input and spins forever instead of failing. `flutter devices` lists ids.
- Map screens render as a grey rectangle — no Google Maps API key configured,
  intentional for the workshop.
- During the session you'll `git checkout` a different branch per exercise.
  Don't fix anything on `main` beforehand — it's the clean baseline your
  sanity-check just proved works.
