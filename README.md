# Patrol Webinar

Sample conference app used for Patrol webinars and live streams. The project shows how to write E2E tests for realistic Flutter user flows: onboarding, login, agenda browsing, speakers, session details, and native interactions such as permissions or maps.

## Setup

Requirements: [fvm](https://fvm.app), Android Studio or Xcode with a running emulator/simulator.

```sh
fvm install
fvm flutter pub get
```

The packages under `packages/` are members of a pub workspace, so that one `pub get` resolves them too, their `dev_dependencies` included.

Run the app:

```sh
fvm flutter run --flavor dev -t lib/main_dev.dart   # dev
fvm flutter run --flavor tst -t lib/main_tst.dart   # tst, the flavor Patrol uses
```

The app talks to a LeanCode staging environment (`*.patrol-webinar.test.lncd.pl`): CQRS API, Kratos for auth, LeanPipe for push.

## Google Maps API key

Map screens need a key with the Google Maps SDK enabled. Android: `manifestPlaceholders.googleMapsApiKey` in `android/app/build.gradle` for the `dev` and `tst` flavors. iOS: `GMSServices.provideAPIKey` in `ios/Runner/AppDelegate.swift`. Both currently hold `<YOUR_API_KEY>`; map screens render blank until a real key is supplied.

Do not commit a real key if the repository is public or shared outside a trusted team.

## Patrol tests

`patrol_cli` resolves from the lockfile, so run it through the project:

```sh
fvm dart run patrol_cli:main test                                           # everything
fvm dart run patrol_cli:main test -t patrol_test/scenarios/signup_test.dart  # one scenario
```

Single test runs during development should go through the Patrol MCP server rather than the CLI — it keeps a live session, so the native tree and screenshots stay available when a test fails, and re-runs skip the rebuild.

Some scenarios need credentials via `--dart-define`, declared in `patrol_test/common/env_variables.dart`: `EMAIL`, `PASSWORD`, `FIRSTNAME`, `LASTNAME`, `DOMAIN_NAME`, `MAILPIT_LOGIN`, `MAILPIT_PASSWORD`, `MAILBOX_API_KEY`. Keep them in a local `.patrol.env`, which is gitignored.

Test architecture — modules, `System`, api clients — is documented in `.claude/skills/patrol-tests/SKILL.md`.
