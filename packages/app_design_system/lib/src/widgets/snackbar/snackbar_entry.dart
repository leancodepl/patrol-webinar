import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// The internal status of a snackbar entry. Documentation of different states
/// uses concepts of t0, t1, t2, t3 and t4 time stamps which were defined in the
/// [SnackbarEntry] class docs.
enum _Status {
  /// The snackbar is queued and awaiting display. It remains in this state
  /// from the initial queue time (t0) until it begins to show (t1).
  ///
  /// See [SnackbarEntry] for t0 and t1 definitions.
  waitingInQueue,

  /// The snackbar is currently displayed and interactive. This state persists
  /// from the moment it becomes visible (t1) until it's marked for removal (t3).
  ///
  /// See [SnackbarEntry] for t1 and t3 definitions.
  active,

  /// The snackbar has completed its display cycle and is scheduled for removal.
  /// It is removed from the queue at the moment marked as t3. This removal
  /// triggers the leave animation, which keeps it displayed until t4 when it's
  /// finally gone from view.
  ///
  /// See [SnackbarEntry] for t3 and t4 definitions.
  finished,
}

/// A snackbar entry that is pushed to the queue and animated in and out.
///
/// You can imagine entry animation as the following graph where x-axis is time
/// and y-axis is visibility. The graph consists of 5 time points: t0, t1, t2
/// t3 and t4. The entry is pushed to the queue at time t0. At time t1 the
/// entry is shown thus starting to animate in. At time t2 the entry is fully
/// visible and until time t3 it is active. At time t3 the entry is being
/// removed from the queue and at time t4 the entry is fully hidden.
///
/// visibility  ^
///             |
///             |
///           1 +       o------------o
///             |      /              \
///             |     /                \
///             |    /                  \
///           0 +---o--------------------o----->
///            t0  t1   t2          t3   t4   time
///
/// See also:
/// * [_Status] enum for the different states of a snackbar entry.
@internal
class SnackbarEntry {
  SnackbarEntry({
    required this.crossPage,
    required this.snackbar,
    required TickerProvider vsync,
    required this.duration,
    required this.onFinished,
    required this.completer,
  }) {
    _timerController = AnimationController(
      vsync: vsync,
      duration: duration,
      debugLabel: 'SnackbarEntry',
    );
    _timerController.addStatusListener(_onAnimationStatusChanged);
  }

  final bool crossPage;
  final Widget snackbar;
  final Duration duration;
  late final AnimationController _timerController;
  final Completer<void> completer;

  final VoidCallback onFinished;

  var _status = _Status.waitingInQueue;

  _Status get status => _status;

  Animation<double> get timer => _timerController;

  bool get isWaitingInQueue => status == _Status.waitingInQueue;

  bool get isActive => status == _Status.active;

  bool get isFinished => status == _Status.finished;

  void _setStatus(_Status status) {
    if (status == _status) {
      return;
    }
    _status = status;
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _setStatus(_Status.finished);
      onFinished();
    }
  }

  void enter() {
    if (_status != _Status.waitingInQueue) {
      return;
    }

    _timerController.forward();
    _setStatus(_Status.active);
  }

  void leaveAndDispose() {
    if (isFinished) {
      return;
    }
    _timerController
      ..value = 1
      ..dispose();
  }

  void pause() {
    if (isFinished) {
      return;
    }
    _timerController.stop();
  }

  void resume() {
    if (isFinished) {
      return;
    }
    _timerController.forward();
  }
}
