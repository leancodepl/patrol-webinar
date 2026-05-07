part of 'tooltip.dart';

class AppTooltipRegistry extends StatefulWidget {
  const AppTooltipRegistry({super.key, required this.child});

  final Widget child;

  @override
  State<AppTooltipRegistry> createState() => _AppTooltipRegistryState();
}

class _AppTooltipRegistryState extends State<AppTooltipRegistry> {
  final _registryKey = GlobalKey();

  late final TooltipRegistryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TooltipRegistryController(registryKey: _registryKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _registryKey,
      child: InheritedTooltipRegistryController(
        controller: _controller,
        child: ClipRect(
          child: Portal(
            labels: const [AppTooltip._arrowPortalLabel],
            child: Portal(
              labels: const [AppTooltip._balloonPortalLabel],
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
