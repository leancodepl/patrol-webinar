part of 'snackbar.dart';

class AppSnackbarSceneReporter extends StatefulWidget {
  const AppSnackbarSceneReporter({super.key, this.child});

  final Widget? child;

  @override
  State<AppSnackbarSceneReporter> createState() =>
      _AppSnackbarSceneReporterState();
}

class _AppSnackbarSceneReporterState extends State<AppSnackbarSceneReporter> {
  final _key = GlobalKey(debugLabel: 'AppSnackbarSceneReporter');

  _SnackbarSceneRegistry? _registry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registry = _SnackbarSceneRegistry.of(context);
    if (registry != _registry) {
      _unregister();
      _registry = registry;
    }
  }

  @override
  void dispose() {
    scheduleMicrotask(_unregister);
    super.dispose();
  }

  void _register() {
    if (_registry case final registry?) {
      registry.register(_key);
    }
  }

  void _unregister() {
    if (_registry case final registry? when !registry.isDisposed) {
      registry.unregister(_key);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _register());
    return KeyedSubtree(
      key: _key,
      child: widget.child ?? const SizedBox.expand(),
    );
  }
}
