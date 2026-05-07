import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

typedef SecondsLeftWidgetBuilder =
    Widget Function(BuildContext context, int secondsLeft);

class SecondsLeftBuilder extends TimerRefreshWidget {
  const SecondsLeftBuilder({
    super.key,
    required this.builder,
    required this.date,
    Duration super.refreshRate,
  });

  final SecondsLeftWidgetBuilder builder;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final difference = date.difference(clock.now());

    return builder(context, difference.inSeconds);
  }
}
