import 'dart:async';

import 'package:patrol/patrol.dart';

extension PatrolFinderX on PatrolFinder {
  Future<void> waitUntilNotVisible({
    Duration timeout = const Duration(seconds: 10),
  }) {
    final completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (finder.evaluate().isEmpty) {
        timer.cancel();
        completer.complete();
      } else if (timer.tick >= timeout.inSeconds) {
        timer.cancel();
        completer.completeError(
          Exception(
            'Element $finder is still visible after ${timeout.inSeconds} seconds',
          ),
        );
      }
    });

    return completer.future;
  }
}
