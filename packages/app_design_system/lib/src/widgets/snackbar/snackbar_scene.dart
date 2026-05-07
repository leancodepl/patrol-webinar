part of 'snackbar.dart';

class AppSnackbarScene extends StatefulWidget {
  const AppSnackbarScene({super.key, required this.child});

  final Widget child;

  @override
  State<AppSnackbarScene> createState() => _AppSnackbarSceneState();
}

class _AppSnackbarSceneState extends State<AppSnackbarScene> {
  final _key = GlobalKey(debugLabel: 'AppSnackbarScene stack');
  late final _SnackbarSceneRegistry _registry;

  static const _transitionDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _registry = _SnackbarSceneRegistry(sceneKey: _key);
  }

  @override
  void dispose() {
    _registry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _registry,
      builder: (context, _) {
        final rect = _registry.getTopSceneRect();
        return _InheritedSnackbarSceneRegistry(
          registry: _registry,
          child: Stack(
            key: _key,
            children: [
              widget.child,
              if (rect != null)
                AnimatedPositioned.fromRect(
                  duration: _transitionDuration,
                  rect: rect,
                  child: const _SnackbarSwitcher(),
                )
              else
                const AnimatedPositioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  duration: Duration(milliseconds: 200),
                  child: _SnackbarSwitcher(),
                ),
            ],
          ),
        );
      },
    );
  }
}
