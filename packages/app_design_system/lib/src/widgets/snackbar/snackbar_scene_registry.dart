part of 'snackbar.dart';

final _deepEquals = const DeepCollectionEquality.unordered().equals;

class _SnackbarSceneRegistry extends ChangeNotifier {
  _SnackbarSceneRegistry({required this.sceneKey});

  final GlobalKey sceneKey;
  final _scenes = <GlobalKey, Rect>{};

  var _disposed = false;

  bool get isDisposed => _disposed;

  void register(GlobalKey key) {
    final ancestor = sceneKey.currentContext?.findRenderObject();
    final rect = key.getGlobalRect(ancestor: ancestor);
    if (rect == null) {
      return;
    }

    final scenes = {..._scenes, key: rect};
    if (_deepEquals(scenes, _scenes)) {
      return;
    }

    _scenes
      ..clear()
      ..addAll(scenes);

    notifyListeners();
  }

  void unregister(GlobalKey key) {
    _scenes.remove(key);
    notifyListeners();
  }

  Rect? getTopSceneRect() {
    return _scenes.values.lastOrNull;
  }

  @override
  void dispose() {
    _disposed = true;
    _scenes.clear();
    super.dispose();
  }

  static _SnackbarSceneRegistry of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedSnackbarSceneRegistry>()!
        .registry;
  }
}

class _InheritedSnackbarSceneRegistry extends InheritedWidget {
  const _InheritedSnackbarSceneRegistry({
    required this.registry,
    required super.child,
  });

  final _SnackbarSceneRegistry registry;

  @override
  bool updateShouldNotify(_InheritedSnackbarSceneRegistry oldWidget) {
    return registry != oldWidget.registry;
  }
}
