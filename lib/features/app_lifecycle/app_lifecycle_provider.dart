import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class AppLifecycleProvider with WidgetsBindingObserver {
  AppLifecycleProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  final _streamController = BehaviorSubject<AppLifecycleStateRecord>.seeded((
    previous: null,
    current:
        WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.detached,
  ));

  Stream<AppLifecycleStateRecord> get stream => _streamController.stream;

  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final previousState = _streamController.value.current;
    if (state == previousState) {
      return;
    }

    final record = (previous: previousState, current: state);
    _streamController.add(record);
  }
}

typedef AppLifecycleStateRecord = ({
  AppLifecycleState? previous,
  AppLifecycleState current,
});
