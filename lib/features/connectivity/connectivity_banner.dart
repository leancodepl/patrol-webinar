import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/connectivity/connectivity_cubit.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class ConnectivityBanner extends HookWidget {
  const ConnectivityBanner({
    super.key,
    this.restoredConnectionVisibilityDuration =
        defaultRestoredConnectionVisibilityDuration,
  });

  final Duration restoredConnectionVisibilityDuration;

  static const defaultRestoredConnectionVisibilityDuration = Duration(
    seconds: 4,
  );

  static const height = 56.0;

  @override
  Widget build(BuildContext context) {
    final state = useState(
      _initialBannerState(
        connectivityState: context.read<ConnectivityCubit>().state,
      ),
    );

    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, connectivityState) {
        final newState = _updatedBannerState(
          connectivityState: connectivityState,
          currentState: state.value,
        );
        state.value = newState;

        if (newState == ConnectivityBannerState.showingSuccess) {
          _dismissBannerAfterDelay(state, context);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: state.value.height,
        child: Container(
          color: state.value.backgroundColor(context),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                AppIcon(
                  state.value.icon,
                  size: AppStandardIconSize.s24,
                  color: context.colors.foregroundInversePrimary,
                  semanticsLabel: null,
                ),
                const SizedBox(width: 10),
                AppText(
                  state.value.text(context),
                  style: AppTextStyles.bodyDefault,
                  color: context.colors.foregroundInversePrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ConnectivityBannerState _initialBannerState({
    required ConnectivityState connectivityState,
  }) => switch (connectivityState) {
    ConnectivityStateConnected() => ConnectivityBannerState.hidden,
    ConnectivityStateDisconnected() => ConnectivityBannerState.showingFailure,
    ConnectivityStateUnknown() => ConnectivityBannerState.hidden,
  };

  ConnectivityBannerState _updatedBannerState({
    required ConnectivityState connectivityState,
    required ConnectivityBannerState currentState,
  }) => switch (connectivityState) {
    ConnectivityStateConnected() => switch (currentState) {
      ConnectivityBannerState.showingSuccess =>
        ConnectivityBannerState.showingSuccess,
      ConnectivityBannerState.showingFailure =>
        ConnectivityBannerState.showingSuccess,
      ConnectivityBannerState.hidden => ConnectivityBannerState.hidden,
    },
    ConnectivityStateDisconnected() => ConnectivityBannerState.showingFailure,
    ConnectivityStateUnknown() => ConnectivityBannerState.hidden,
  };

  void _dismissBannerAfterDelay(
    ValueNotifier<ConnectivityBannerState> state,
    BuildContext context,
  ) {
    Future.delayed(restoredConnectionVisibilityDuration, () {
      if (!context.mounted) {
        return;
      }

      final isConnected = context.read<ConnectivityCubit>().state.isConnected;
      if (!isConnected) {
        return;
      }

      state.value = ConnectivityBannerState.hidden;
    });
  }
}

enum ConnectivityBannerState {
  showingSuccess,
  showingFailure,
  hidden;

  double get height => switch (this) {
    ConnectivityBannerState.showingSuccess => ConnectivityBanner.height,
    ConnectivityBannerState.showingFailure => ConnectivityBanner.height,
    ConnectivityBannerState.hidden => 0,
  };

  AppColor backgroundColor(BuildContext context) => switch (this) {
    ConnectivityBannerState.showingSuccess =>
      context.colors.foregroundSuccessPrimary,
    ConnectivityBannerState.showingFailure =>
      context.colors.foregroundDangerPrimary,
    ConnectivityBannerState.hidden => context.colors.foregroundSuccessPrimary,
  };

  AppIconData get icon => switch (this) {
    ConnectivityBannerState.showingSuccess => AppStandardIcons.wifi,
    ConnectivityBannerState.showingFailure => AppStandardIcons.wifiOff,
    ConnectivityBannerState.hidden => AppStandardIcons.wifi,
  };

  String text(BuildContext context) {
    final s = l10n(context);
    return switch (this) {
      ConnectivityBannerState.showingSuccess =>
        s.connectivityBanner_connectionRestored,
      ConnectivityBannerState.showingFailure =>
        s.connectivityBanner_connectionUnavailable,
      ConnectivityBannerState.hidden => s.connectivityBanner_connectionRestored,
    };
  }
}
