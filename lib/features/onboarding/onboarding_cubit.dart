import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.prefs})
    : super(switch (prefs.getBool(_onboardingCompletedKey)) {
        true => OnboardingState.completed,
        false || null => OnboardingState.notCompleted,
      });

  static const _onboardingCompletedKey = 'onboardingCompleted';

  final SharedPreferences prefs;

  void complete() {
    emit(OnboardingState.completed);
    prefs.setBool(_onboardingCompletedKey, true);
  }
}

enum OnboardingState { notCompleted, completed }
