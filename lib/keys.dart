import 'package:fts/features/app_shell/keys.dart';
import 'package:fts/features/auth/keys.dart';
import 'package:fts/features/force_update/keys.dart';
import 'package:fts/features/home/keys.dart';
import 'package:fts/features/onboarding/keys.dart';
import 'package:fts/features/session_details/keys.dart';
import 'package:fts/features/settings/keys.dart';
import 'package:fts/features/speaker_details/keys.dart';

final keys = Keys();

class Keys {
  final appForceUpdateScreen = AppForceUpdateScreenKeys();
  final appShell = AppShellKeys();
  final appSuggestUpdateDialog = AppSuggestUpdateDialogKeys();
  final home = HomePageKeys();
  final loginPage = LoginPageKeys();
  final loginWithCredentialsPage = LoginWithCredentialsPageKeys();
  final menu = MenuPageKeys();
  final onboarding = OnboardingKeys();
  final registerPage = RegisterPageKeys();
  final sessionDetails = SessionDetailsKeys();
  final settingsPage = SettingsPageKeys();
  final speakerDetails = SpeakerDetailsPageKeys();
  final verificationPage = VerificationPageKeys();
}
