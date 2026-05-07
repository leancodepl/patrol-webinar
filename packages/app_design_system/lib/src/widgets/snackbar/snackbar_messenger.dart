import 'dart:async';
import 'dart:collection';

import 'package:app_design_system/src/widgets/snackbar/snackbar.dart';
import 'package:app_design_system/src/widgets/snackbar/snackbar_entry.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Manages the snackbar queue making sure that each is displayed for a proper
/// amount of time and that only one is displayed at a time.
@internal
class SnackbarMessenger extends ChangeNotifier {
  SnackbarMessenger({required this.vsync});

  final TickerProvider vsync;

  final _queue = Queue<SnackbarEntry>();

  void _add(SnackbarEntry entry) {
    _queue.add(entry);
    if (_isFirst(entry)) {
      _showFirstIfPossible();
    }
    notifyListeners();
  }

  void _remove(SnackbarEntry entry) {
    if (!_queue.contains(entry) || entry.completer.isCompleted) {
      return;
    }

    final wasFirst = _isFirst(entry);
    _queue.remove(entry);
    entry.leaveAndDispose();
    if (wasFirst) {
      _showFirstIfPossible();
    }
    entry.completer.complete();
    notifyListeners();
  }

  bool _isFirst(SnackbarEntry entry) {
    return firstEntryOrNull == entry;
  }

  /// Returns the first snackbar entry in the queue or null if the queue is
  /// empty.
  SnackbarEntry? get firstEntryOrNull {
    return _queue.firstOrNull;
  }

  List<SnackbarEntry> get entries => List.unmodifiable(_queue);

  void _showFirstIfPossible() {
    if (firstEntryOrNull case final first? when first.isWaitingInQueue) {
      first.enter();
    }
  }

  /// Removes all snackbars that are not cross-page.
  ///
  /// This is used to remove snackbars when navigating to a new page.
  void removeNonCrossPage() {
    scheduleMicrotask(() {
      _queue.where((entry) => !entry.crossPage).toList().forEach(_remove);
    });
  }

  /// Pushes a snackbar to the queue.
  Future<void> push({
    required bool crossPage,
    required Duration duration,
    required AppSnackbar snackbar,
  }) {
    final completer = Completer<void>();

    late final SnackbarEntry entry;
    entry = SnackbarEntry(
      vsync: vsync,
      duration: duration,
      crossPage: crossPage,
      snackbar: snackbar,
      onFinished: () => _remove(entry),
      completer: completer,
    );

    _add(entry);
    return completer.future;
  }

  void clear() {
    Queue.of(_queue).forEach(_remove);
  }

  void pop() {
    if (firstEntryOrNull case final first?) {
      _remove(first);
    }
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
