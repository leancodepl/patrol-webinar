import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/app_lifecycle/app_lifecycle_provider.dart';
import 'package:http/http.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({
    required this.appLifecycleProvider,
    required this.healthCheckUri,
    required this.client,
    required this.healthCheckConnectedPeriod,
    required this.healthCheckDisconnectedPeriod,
  }) : super(const ConnectivityStateUnknown());

  final AppLifecycleProvider appLifecycleProvider;
  final Uri healthCheckUri;
  final Client client;
  final Duration healthCheckConnectedPeriod;
  final Duration healthCheckDisconnectedPeriod;

  StreamSubscription<AppLifecycleStateRecord>? _appLifecycleSubscription;

  Future<void> init() async {
    _appLifecycleSubscription = appLifecycleProvider.stream.listen(
      _onAppLifecycleChange,
    );
    await _checkConnectivity();
  }

  void onApiResult(CqrsConnectivityResult result) {
    if (state.isCheckingConnectivity) {
      return;
    }

    if (state.isConnected ^ (result == CqrsConnectivityResult.success)) {
      _checkConnectivity();
    }
  }

  Future<void> _checkConnectivity() async {
    emit(state.copyWith(isCheckingConnectivity: true));

    bool isConnected;

    try {
      final response = await client.get(healthCheckUri);
      isConnected = response.statusCode == 200;
    } catch (err) {
      isConnected = false;
    }

    final didConnectionStatusChange =
        state is ConnectivityStateUnknown || isConnected != state.isConnected;

    if (didConnectionStatusChange) {
      _startTimer(isConnected: isConnected);
    } else {
      emit(state.copyWith(isCheckingConnectivity: false));
    }
  }

  void _startTimer({required bool isConnected}) {
    state.timer?.cancel();

    final duration = isConnected
        ? healthCheckConnectedPeriod
        : healthCheckDisconnectedPeriod;
    final timer = Timer.periodic(duration, (timer) {
      _checkConnectivity();
    });
    emit(
      ConnectivityState.build(
        isCheckingConnectivity: false,
        isConnected: isConnected,
        timer: timer,
      ),
    );
  }

  void _onAppLifecycleChange(AppLifecycleStateRecord stateRecord) {
    final appState = stateRecord.current;
    final shouldStopTimer =
        appState == AppLifecycleState.inactive ||
        appState == AppLifecycleState.hidden ||
        appState == AppLifecycleState.paused;
    final shouldResumeTimer =
        appState == AppLifecycleState.resumed && !state.isCheckingConnectivity;

    if (shouldStopTimer) {
      state.timer?.cancel();
      emit(state.copyWithNullTimer());
    } else if (shouldResumeTimer) {
      _startTimer(isConnected: state.isConnected);
    }
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    _appLifecycleSubscription?.cancel();
    return super.close();
  }
}

enum CqrsConnectivityResult { success, networkError }

sealed class ConnectivityState with EquatableMixin {
  const ConnectivityState({this.isCheckingConnectivity = false});

  factory ConnectivityState.build({
    required bool isCheckingConnectivity,
    required bool isConnected,
    required Timer timer,
  }) => isConnected
      ? ConnectivityStateConnected(
          isCheckingConnectivity: isCheckingConnectivity,
          timer: timer,
        )
      : ConnectivityStateDisconnected(
          isCheckingConnectivity: isCheckingConnectivity,
          timer: timer,
        );

  final bool isCheckingConnectivity;

  bool get isConnected => switch (this) {
    ConnectivityStateUnknown() => false,
    ConnectivityStateConnected() => true,
    ConnectivityStateDisconnected() => false,
  };

  Timer? get timer;

  ConnectivityState copyWithNullTimer() => switch (this) {
    ConnectivityStateUnknown() => this,
    ConnectivityStateConnected() => ConnectivityStateConnected(
      isCheckingConnectivity: isCheckingConnectivity,
    ),
    ConnectivityStateDisconnected() => ConnectivityStateDisconnected(
      isCheckingConnectivity: isCheckingConnectivity,
    ),
  };

  ConnectivityState copyWith({bool? isCheckingConnectivity}) => switch (this) {
    ConnectivityStateUnknown() => ConnectivityStateUnknown(
      isCheckingConnectivity:
          isCheckingConnectivity ?? this.isCheckingConnectivity,
    ),
    ConnectivityStateConnected() => ConnectivityStateConnected(
      isCheckingConnectivity:
          isCheckingConnectivity ?? this.isCheckingConnectivity,
      timer: timer,
    ),
    ConnectivityStateDisconnected() => ConnectivityStateDisconnected(
      isCheckingConnectivity:
          isCheckingConnectivity ?? this.isCheckingConnectivity,
      timer: timer,
    ),
  };

  @override
  List<Object?> get props => [isCheckingConnectivity];
}

final class ConnectivityStateUnknown extends ConnectivityState {
  const ConnectivityStateUnknown({super.isCheckingConnectivity});

  @override
  Timer? get timer => null;
}

final class ConnectivityStateConnected extends ConnectivityState {
  const ConnectivityStateConnected({super.isCheckingConnectivity, this.timer});

  @override
  final Timer? timer;

  @override
  List<Object?> get props => [super.props, timer];
}

final class ConnectivityStateDisconnected extends ConnectivityState {
  const ConnectivityStateDisconnected({
    super.isCheckingConnectivity,
    this.timer,
  });

  @override
  final Timer? timer;

  @override
  List<Object?> get props => [super.props, timer];
}
