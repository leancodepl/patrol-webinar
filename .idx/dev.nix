# Firebase Studio (Project IDX) environment for running Patrol + Claude Code in the cloud.
# Docs: https://developers.google.com/idx/guides/customize-idx-env
# Adapted from https://github.com/leancodepl/patrol-idx-demo for this project:
#   app_name: FlutterTechSummit | flavor: tst | entrypoint: lib/main_tst.dart
{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = [
    pkgs.jdk17
    pkgs.unzip
    pkgs.jq
    pkgs.git
    pkgs.curl
  ];

  env = { };

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    workspace = {
      # Runs once, when the workspace is first created.
      onCreate = {
        setup = ''
          # Make pub-global executables (patrol) available in every terminal.
          echo 'export PATH="$HOME/.pub-cache/bin:$PATH"' >> "$HOME/.bashrc"
          export PATH="$HOME/.pub-cache/bin:$PATH"

          # Firebase Studio ships Flutter 3.35.2, but this project requires >=3.41.0.
          # Upgrade the pre-installed SDK in place to the pinned 3.41.7 (no fvm needed):
          # it stays on the existing PATH, so plain `flutter` becomes the right version.
          git config --global --add safe.directory "$HOME/flutter"
          git -C "$HOME/flutter" fetch --tags --depth 1 origin refs/tags/3.41.7
          git -C "$HOME/flutter" checkout 3.41.7
          flutter --version
          flutter precache --android

          # Resolve dependencies and pin a patrol_cli compatible with patrol 4.5.0.
          flutter pub get
          flutter pub global activate patrol_cli 4.3.1
        '';
      };

      # Runs every time the workspace (re)starts.
      onStart = {
        default.openFiles = [ "patrol_test/scenarios/signup_profile_visible_test.dart" ];
        wait-for-emulator = ''
          export PATH="$HOME/.pub-cache/bin:$PATH"

          # Block until the Android emulator is attached and reported by Flutter.
          while true; do
            DEVICE_ID=$(flutter devices --machine | jq -r '.[0].id // empty')
            if [[ "$DEVICE_ID" == *emulator* ]]; then
              echo "Emulator ready: $DEVICE_ID"
              break
            fi
            echo "Waiting for emulator..."
            sleep 5
          done

          # Pre-generate the flavor build config so the first Patrol run is faster.
          flutter build apk --config-only -t lib/main_tst.dart --flavor tst
        '';
      };
    };

    # Provisions the in-cloud Android emulator.
    previews = {
      enable = true;
      previews = {
        android = {
          command = [ "yes" ];
          manager = "android";
        };
      };
    };
  };
}
