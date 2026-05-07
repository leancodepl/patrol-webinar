import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
typedef ScaffoldContentScrollBuilder =
    Widget Function(
      BuildContext context,
      bool endOfScrollReached,
      bool hasScrollExtent,
      bool didOverscrollBottom,
    );

@internal
class ScaffoldContentScrollListener extends StatefulWidget {
  const ScaffoldContentScrollListener({super.key, required this.builder});

  final ScaffoldContentScrollBuilder builder;

  @override
  State<ScaffoldContentScrollListener> createState() =>
      _ScaffoldContentScrollListenerState();
}

class _ScaffoldContentScrollListenerState
    extends State<ScaffoldContentScrollListener> {
  var _maxScrollExtentReached = false;
  var _hasScrollExtent = false;
  var _didOverscrollBottom = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        if (notification.depth != 0) {
          return false;
        }

        final hasScrollExtent = notification.metrics.maxScrollExtent > 0;

        final maxScrollExtentReached =
            notification.metrics.atEdge && notification.metrics.pixels > 0;

        final didOverscrollBottom =
            notification.metrics.hasContentDimensions &&
            notification.metrics.hasPixels &&
            notification.metrics.pixels > notification.metrics.maxScrollExtent;

        if (_hasScrollExtent != hasScrollExtent ||
            _maxScrollExtentReached != maxScrollExtentReached ||
            _didOverscrollBottom != didOverscrollBottom) {
          setState(() {
            _hasScrollExtent = hasScrollExtent;
            _maxScrollExtentReached = maxScrollExtentReached;
            _didOverscrollBottom = didOverscrollBottom;
          });
        }

        return false;
      },
      child: widget.builder(
        context,
        _maxScrollExtentReached,
        _hasScrollExtent,
        _didOverscrollBottom,
      ),
    );
  }
}
