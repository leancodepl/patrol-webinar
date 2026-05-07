import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

DateTime useMinuteTimer() {
  final now = clock.now();

  final controller = useStreamController<DateTime>();
  useEffect(() {
    final nextMinute = now.copyWith(
      minute: now.minute + 1,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    Timer? innerTimer;
    final outerTimer = Timer(nextMinute.difference(now), () {
      controller.add(clock.now());

      innerTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
        controller.add(clock.now());
      });
    });

    return () {
      innerTimer?.cancel();
      outerTimer.cancel();
    };
  }, [controller]);

  return useStream(controller.stream).data ?? now;
}
