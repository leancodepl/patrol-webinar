import 'dart:async';

import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Controls the visibility and clickable state of a resend button.
/// The button becomes visible after a delay and has a cooldown period between resends.
class ResendButtonCubit extends Cubit<ResendButtonState> {
  ResendButtonCubit({
    this.visibleAfterDuration = const Duration(seconds: 1),
    this.delayBetweenResend = const Duration(minutes: 1),
  }) : super(
         ResendButtonState(nextResendTime: clock.now(), isButtonVisible: false),
       );

  /// Duration of the delay before the visibility is set to true.
  /// Default is 20 seconds.
  final Duration visibleAfterDuration;

  /// Duration of the delay between resend.
  /// Default is 1 minute.
  final Duration delayBetweenResend;

  late final Timer _timer;

  /// Initializes the resend button.
  /// It sets the timer to make the button visible after the delay.
  void init() {
    _timer = Timer(
      visibleAfterDuration,
      () => emit(state.copyWith(isButtonVisible: true)),
    );
  }

  void markSendAction() {
    _timer.cancel();
    emit(state.copyWith(nextResendTime: clock.fromNowBy(delayBetweenResend)));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}

final class ResendButtonState with EquatableMixin {
  const ResendButtonState({
    required this.nextResendTime,
    required this.isButtonVisible,
  });

  final DateTime nextResendTime;
  final bool isButtonVisible;

  ResendButtonState copyWith({
    DateTime? nextResendTime,
    bool? isButtonVisible,
  }) {
    return ResendButtonState(
      nextResendTime: nextResendTime ?? this.nextResendTime,
      isButtonVisible: isButtonVisible ?? this.isButtonVisible,
    );
  }

  @override
  List<Object?> get props => [nextResendTime, isButtonVisible];
}
